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

// TODO(LoeHen) This class should do the REST class to retrieve data.
public class DataGatherer {
    private static var userUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinus"
    private static var dataUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinusvalue/"
    
    public static func CollectData() -> [SinusData] {
        let decoder = JSONDecoder()
        
        var users = [SinusUserData]()
        var sinusData = [SinusData]()
        var dict: [String: [GraphDataPoint]] = [:]
        
        // Get all users.
        var request = URLRequest(url: URL(string: userUrl)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                users = try decoder.decode([SinusUserData].self, from: data!)
                
                users.forEach { user in
                    let url = URL(string: dataUrl + String(user.id))
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
    
        // WHY CAN SWIFT NOT WAIT FOR A TASK, DUMBASS LANGUAGE
        Thread.sleep(forTimeInterval: 2)
        
        // Construct sinus data
        print(dict)
        
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
