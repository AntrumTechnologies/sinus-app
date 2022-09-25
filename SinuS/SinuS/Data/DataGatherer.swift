//
//  DataGatherer.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import Foundation

// internal struct to hold user data.
private struct SinusUserData : Codable {
    let id: Int
    let name: String
    let date_name: String
}

// internal struct to hold data/date's
private struct GraphDataPoint : Codable {
    let date: String
    let value: Int
}

public class DataManager {
    private static var userUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinus"
    private static var dataUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinusvalue/"
    
    private var users = [SinusUserData]()
    
    public func AddUser(user: String, target: String) {
        let parameters: [String: Any] = ["name": user, "date_name": target]
        var request = URLRequest(url: URL(string: DataManager.userUrl)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response as Any)
        })
        task.resume()
    }
    
    public func SendData(data: SinusUpdate) {
        if let user = self.users.first(where: { user in
            return user.name == data.name
        }) {
            let url = "https://lukassinus2.vanbroeckhuijsenvof.nl/api/sinusvalue"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-d"
            
            let parameters: [String: Any] = ["sinus_id": user.id, "date": formatter.string(from: data.date), "value": data.value]
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "PUT"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                print(response as Any)
            })
            task.resume()
        }
    }
    
    public func CollectData() -> [SinusData] {
        let decoder = JSONDecoder()
        
        var sinusData = [SinusData]()
        var dict: [String: [GraphDataPoint]] = [:]
        
        // Get all users.
        var request = URLRequest(url: URL(string: DataManager.userUrl)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {

                self.users = try decoder.decode([SinusUserData].self, from: data!)
                self.users.forEach { user in
                    let url = URL(string: DataManager.dataUrl + String(user.id))
                    var graphDataRequest = URLRequest(url: url!)
                    graphDataRequest.httpMethod = "GET"
                    graphDataRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    let session2 = URLSession.shared
                    let task2 = session2.dataTask(with: graphDataRequest, completionHandler: { data2, response2, error2 -> Void in
                        do {
                            let points = try decoder.decode([GraphDataPoint].self, from: data2!)
                            dict.updateValue(points, forKey: user.name)
                        } catch {
                            print(error2!.localizedDescription)
                        }
                    })
                    task2.resume()
                    
                }
            } catch {
                print(error.localizedDescription)
            }
        })
        task.resume()
        
        // Increase sleep for now, issue can be fixed when we refactor this class.
        // Described: https://github.com/patbro/sinus-app/issues/8
        Thread.sleep(forTimeInterval: 2)
        
        dict.forEach { kvp in
            let values = kvp.value.map { p in p.value }
            let labels = kvp.value.map { p in p.date }
            
            if let user = users.first(where: { user in
                return user.name == kvp.key
            }) {
                sinusData.append(SinusData(id: user.id, values: values, labels: labels, sinusName: kvp.key, sinusTarget: user.date_name))
            }
        }
        return sinusData
    }
}
