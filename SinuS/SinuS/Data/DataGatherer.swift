//
//  DataGatherer.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import Foundation
import UIKit

/**
    Internal struct to hold data/date's
 */
private struct GraphDataPoint : Codable {
    let date: String
    let value: Int
    let deleted_at: String?
}

/**
    Class responsible for storing and retrieve data to and from the backend.
 */
public class DataManager {
    // endpoints
    private static var userUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinus"
    private static var dataUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinusvalue/"
    
    private var users = [SinusUserData]()
    
    /**
        Register call to the backend.
     */
    public func Register(name: String, email: String, password: String, confirmPassword: String) -> AuthenticationResult? {
        let semaphore = DispatchSemaphore.init(value: 0)
        let registerUrl = "https://lukassinus2.vanbroeckhuijsenvof.nl/api/register?"
        let parameters: [String: Any] = ["name": name, "email": email, "password": password, "confirm_password": confirmPassword]
        let decoder = JSONDecoder()
        
        var request = URLRequest(url: URL(string: registerUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
        
        var result: AuthenticationResult? = nil
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    ContentView.Cookie = httpResponse.value(forHTTPHeaderField: "Set-Cookie")!
                }
                defer { semaphore.signal() }
                print(data!)
                result = try decoder.decode(AuthenticationResult.self, from: data!)
            } catch {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        semaphore.wait()
        return result
    }
    
    /**
        Login call to the backend.
     */
    public func Login(email: String, password: String) -> AuthenticationResult? {
        let semaphore = DispatchSemaphore.init(value: 0)
        let loginUrl = "https://lukassinus2.vanbroeckhuijsenvof.nl/api/login?"
        let parameters: [String: Any] = ["email": email, "password": password]
        let decoder = JSONDecoder()
        
        var request = URLRequest(url: URL(string: loginUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        catch let error {
            print(error.localizedDescription)
            return nil
        }
        
        var result: AuthenticationResult? = nil
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if let httpResponse = response as? HTTPURLResponse {
                    ContentView.Cookie = httpResponse.value(forHTTPHeaderField: "Set-Cookie") ?? ""
                }
                
                defer { semaphore.signal() }
                result = try decoder.decode(AuthenticationResult.self, from: data!)
            } catch {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        semaphore.wait()
        return result
    }
    
    /**
        Creates a new user.
     */
    public func AddUser(user: String, target: String) -> Bool {
        let sem = DispatchSemaphore.init(value: 0)
        let parameters: [String: Any] = ["name": user, "date_name": target]
        
        var request = URLRequest(url: URL(string: DataManager.userUrl)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ContentView.Cookie, forHTTPHeaderField: "Cookie")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
        catch let error {
            print(error.localizedDescription)
            return false
        }
        
        let session = URLSession.shared
        var success = false;
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            defer { sem.signal() }
            print(response as Any)
            
            if (error.debugDescription == "") {
                success = true
            }
            
            print(error.debugDescription)
        })
        
        task.resume()
        sem.wait()
        
        print(success)
        return success
    }
    
    /**
        Updates the graphs for a user by adding a new point.
     */
    public func SendData(data: SinusUpdate) {
        print("SendData")
        let sem = DispatchSemaphore.init(value: 0)
        
        if (users.count < 1) {
            _ = self.GatherUsers(onlyFollowing: false)
        }
        
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
            request.addValue(ContentView.Cookie, forHTTPHeaderField: "Cookie")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                defer { sem.signal() }
                print(response as Any)
            })
            
            task.resume()
            sem.wait()
        }
    }
    
    
    /**
        Gathers the list of users.
     */
    public func GatherUsers(onlyFollowing: Bool) -> [SinusUserData] {
        let decoder = JSONDecoder()
        
        var internalUsers = [SinusUserData]()
        let sem = DispatchSemaphore.init(value: 0)
        
        var url = DataManager.userUrl
        if (onlyFollowing) {
            url += "/following"
        }
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ContentView.Cookie, forHTTPHeaderField: "Cookie")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                defer { sem.signal() }
                internalUsers = try decoder.decode([SinusUserData].self, from: data!)
            } catch {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
        sem.wait()
        
        self.users = internalUsers
        return internalUsers
    }
    
    public func UnFollowUser(user_id: Int) {
        let sem = DispatchSemaphore.init(value: 0)
        
        let urlString = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/unfollow"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ContentView.Cookie, forHTTPHeaderField: "Cookie")
        
        
        let parameters: [String: Any] = ["user_id_to_unfollow": user_id,]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            defer { sem.signal() }
            print(response as Any)
        })
        
        task.resume()
        sem.wait()
    }
    
    public func FollowUser(user_id: Int) {
        let sem = DispatchSemaphore.init(value: 0)
        
        let urlString = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/follow"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(ContentView.Cookie, forHTTPHeaderField: "Cookie")
        
        
        let parameters: [String: Any] = ["user_id_to_follow": user_id,]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            defer { sem.signal() }
            print(response as Any)
        })
        
        task.resume()
        sem.wait()
    }
    
    
    /**
        Retrieves the Sinus data for a single user.
     */
    public func GatherSingleData(user: SinusUserData) -> SinusData {
        let decoder = JSONDecoder()
        let url = URL(string: DataManager.dataUrl + String(user.id))
        var points = [GraphDataPoint]()
        let sem = DispatchSemaphore.init(value: 0)
        
        var graphDataRequest = URLRequest(url: url!)
        graphDataRequest.httpMethod = "GET"
        graphDataRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        graphDataRequest.addValue(ContentView.Cookie, forHTTPHeaderField: "Cookie")
        let session = URLSession.shared
        let task = session.dataTask(with: graphDataRequest, completionHandler: { data2, response2, error2 -> Void in
            do {
                defer { sem.signal() }
                print(data2!)
                points = try decoder.decode([GraphDataPoint].self, from: data2!)
            } catch {
                print(error2!.localizedDescription)
            }
        })
        
        task.resume()
        sem.wait()
        
        var values = [Int]()
        var labels = [String]()
        points.forEach { p in
            values.append(p.value)
            labels.append(p.date)
        }
        
        return SinusData(id: user.id, values: values, labels: labels, sinusName: user.name, sinusTarget: user.date_name)
    }
}
