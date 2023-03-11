//
//  DataGatherer.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import Foundation
import UIKit
import Get
import SwiftKeychainWrapper

/**
    Internal struct to hold data/date's
 */
private struct GraphDataPoint: Codable {
    let date: String
    let value: Int
    let deleted_at: String?
    let latitude: Double?
    let longitude: Double?
    let tags: String?
    let description: String?
}

/**
    Class responsible for storing and retrieve data to and from the backend.
 */
public class DataManager {
    // endpoints
    private static var userUrl = "https://www.lovewaves.antrum-technologies.nl/api/sinus"
    private static var dataUrl = "https://www.lovewaves.antrum-technologies.nl/api/sinusvalue/"

    private var users = [SinusUserData]()
    private var logHelper = LogHelper()

    /**
        Register call to the backend.
     */
    public func register(
        name: String,
        email: String,
        password: String,
        confirmPassword: String) -> AuthenticationResult? {
        let registerUrl = "https://lovewaves.antrum-technologies.nl/api/register?"
        let parameters: [String: Any] = [
            "name": name, "email": email, "password": password, "confirm_password": confirmPassword]
        let decoder = JSONDecoder()
        var request = RestApiHelper.createRequest(type: "POST", url: registerUrl, auth: false)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }

        var result: AuthenticationResult?
        let data = RestApiHelper.perfomRestCall(request: request)

        do {
            result = try decoder.decode(AuthenticationResult.self, from: data!)
        } catch {
            let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
            let errMsg = "Unable to register: \(returnedData)"
            self.logHelper.logMsg(level: "error", message: errMsg)
            print(errMsg)
        }

        return result
    }

    /**
        Login call to the backend.
     */
    public func login(email: String, password: String) -> AuthenticationResult? {
        let loginUrl = "https://lovewaves.antrum-technologies.nl/api/login?"
        let parameters: [String: Any] = ["email": email, "password": password]
        let decoder = JSONDecoder()
        var request = RestApiHelper.createRequest(type: "POST", url: loginUrl, auth: false)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }

        var result: AuthenticationResult?
        let data = RestApiHelper.perfomRestCall(request: request)

        do {
            result = try decoder.decode(AuthenticationResult.self, from: data!)
        } catch {
            let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
            let errMsg = "Unable to login: \(returnedData)"
            self.logHelper.logMsg(level: "error", message: errMsg)
            print(errMsg)
        }

        return result
    }

    public func forgotPassword(email: String) -> AuthenticationResult? {
        let loginUrl = "https://lovewaves.antrum-technologies.nl/api/forgot-password"
        let parameters: [String: Any] = ["email": email]
        let decoder = JSONDecoder()
        var request = RestApiHelper.createRequest(type: "POST", url: loginUrl, auth: false)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }

        var result: AuthenticationResult?
        let data = RestApiHelper.perfomRestCall(request: request)

        do {
            result = try decoder.decode(AuthenticationResult.self, from: data!)
        } catch {
            let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
            let errMsg = "Unable to process forgot password request: \(returnedData)"
            self.logHelper.logMsg(level: "error", message: errMsg)
            print(errMsg)
        }

        return result
    }

    public func resetPassword(token: String, email: String, password: String, confirmPassword: String) -> AuthenticationResult? {
        let loginUrl = "https://lovewaves.antrum-technologies.nl/api/reset-password"
        let parameters: [String: Any] = [
            "token": token,
            "email": email,
            "password": password,
            "password_confirmation": confirmPassword
        ]
        let decoder = JSONDecoder()
        var request = RestApiHelper.createRequest(type: "POST", url: loginUrl, auth: false)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }

        var result: AuthenticationResult?
        let data = RestApiHelper.perfomRestCall(request: request)

        do {
            result = try decoder.decode(AuthenticationResult.self, from: data!)
        } catch {
            let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
            let errMsg = "Unable to reset password: \(returnedData)"
            self.logHelper.logMsg(level: "error", message: errMsg)
            print(errMsg)
        }

        return result
    }

    public func isTokenValid() -> Bool {
        let url = "https://lovewaves.antrum-technologies.nl/api/user"
        let decoder = JSONDecoder()
        let request = RestApiHelper.createRequest(type: "GET", url: url, auth: true)

        var result: UserData?
        let data = RestApiHelper.perfomRestCall(request: request)

        do {
            result = try decoder.decode(UserData.self, from: data!)
            return true
        } catch {
            print("Error info: \(error)")
            return false
        }
    }

    public func getCurrentUser() -> UserData? {
        let url = "https://lovewaves.antrum-technologies.nl/api/user"
        let decoder = JSONDecoder()
        let request = RestApiHelper.createRequest(type: "GET", url: url, auth: true)

        var result: UserData?
        let data = RestApiHelper.perfomRestCall(request: request)

        do {
            result = try decoder.decode(UserData.self, from: data!)
        } catch {
            let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
            let errMsg = "Unable to login: \(returnedData)"
            self.logHelper.logMsg(level: "error", message: errMsg)
            print(errMsg)
        }

        return result
    }

    /**
        Creates a new user.
     */
    public func addUser(user: String, target: String) -> Bool {
        let sem = DispatchSemaphore.init(value: 0)
        let parameters: [String: Any] = ["name": user, "date_name": target]
        var request = RestApiHelper.createRequest(type: "PUT", url: DataManager.userUrl)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return false
        }

        let session = URLSession.shared
        var success = false

        let task = session.dataTask(with: request, completionHandler: { _, response, error -> Void in
            defer { sem.signal() }
            print(response as Any)

            if error.debugDescription == "" {
                success = true
            } else {
                let errMsg = "Unable to addUser: \(error.debugDescription)"
                self.logHelper.logMsg(level: "error", message: errMsg)
                print(errMsg)
            }
        })

        task.resume()
        sem.wait()

        print(success)
        return success
    }

    /**
        Updates the graphs for a user by adding a new point.
     */
    public func updateWave(data: SinusUpdate) {
        let sem = DispatchSemaphore.init(value: 0)

        if users.count < 1 {
            _ = self.gatherUsers()
        }

        if let user = self.users.first(where: { user in
            return user.date_name == data.name
        }) {
            let url = "https://lovewaves.antrum-technologies.nl/api/sinusvalue"

            let formatter = DateFormatter()
            formatter.dateFormat = "y-MM-d"
            print(formatter.string(from: data.date))

            let parameters: [String: Any] = ["sinus_id": user.id, "date":
                    formatter.string(from: data.date), "value": data.value]
            var request = RestApiHelper.createRequest(type: "PUT", url: url)

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }

            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { _, _, _ -> Void in
                defer { sem.signal() }
            })

            task.resume()
            sem.wait()
        }
    }

    /**
        Gathers the list of users.
     */
    public func gatherUsers(postfix: String = "") -> [SinusUserData] {
        let decoder = JSONDecoder()

        var internalUsers = [SinusUserData]()
        let sem = DispatchSemaphore.init(value: 0)

        let url = DataManager.userUrl + postfix

        let request = RestApiHelper.createRequest(type: "GET", url: url)

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, _, _ -> Void in
            do {
                internalUsers = try decoder.decode([SinusUserData].self, from: data!)
                
                    defer { sem.signal() }
            } catch {
                let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
                let errMsg = "Unable to decode points in gatherUsers: \(returnedData)"
                self.logHelper.logMsg(level: "error", message: errMsg)
                print(errMsg)
            }
        })

        task.resume()
        sem.wait()
        self.users = internalUsers
        return internalUsers
    }
    
    public func getSingleUser(user_id: Int) -> SinusUserData {
        let decoder = JSONDecoder()
        let sem = DispatchSemaphore.init(value: 0)
        let url = DataManager.userUrl + "/\(user_id)"
        
        var user: SinusUserData?
        let request = RestApiHelper.createRequest(type: "GET", url: url)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, _, _ -> Void in
            do {
                print(data)
                user = try decoder.decode(SinusUserData.self, from: data!)
                print(user)
                defer { sem.signal()
                    
                }
            } catch {
                let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
                let errMsg = "Unable to decode points in gatherUsers: \(returnedData)"
                self.logHelper.logMsg(level: "error", message: errMsg)
                print(errMsg)
            }
        })

        task.resume()
        sem.wait()
        
        return user!
    }
    


    public func unFollowUser(user_id: Int) {
        let urlString = "https://lovewaves.antrum-technologies.nl/api/unfollow"
        var request = RestApiHelper.createRequest(type: "PUT", url: urlString)

        let parameters: [String: Any] = ["user_id_to_unfollow": user_id ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        _ = RestApiHelper.perfomRestCall(request: request)
    }

    public func followUser(user_id: Int) {
        let urlString = "https://lovewaves.antrum-technologies.nl/api/follow"
        var request = RestApiHelper.createRequest(type: "PUT", url: urlString)

        let parameters: [String: Any] = ["user_id_to_follow": user_id ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        _ = RestApiHelper.perfomRestCall(request: request)
    }

    /**
        Retrieves the Sinus data for a single user.
     */
    public func gatherSingleData(user: SinusUserData) -> SinusData {
        let decoder = JSONDecoder()
        var points = [GraphDataPoint]()
        let request = RestApiHelper.createRequest(type: "GET", url: DataManager.dataUrl + String(user.id))

        let data = RestApiHelper.perfomRestCall(request: request)
        if data != nil {
            do {
                points = try decoder.decode([GraphDataPoint].self, from: data!)
            } catch {
                let returnedData = (String(bytes: data!, encoding: .utf8) ?? "")
                let errMsg = "Unable to decode points in gatherSingleData: \(returnedData)"
                self.logHelper.logMsg(level: "error", message: errMsg)
                print(errMsg)
            }
        }

        var values = [Int]()
        var labels = [String]()
        var descriptions = [String]()
        points.forEach { point in
            values.append(point.value)
            labels.append(point.date)
            descriptions.append(point.description ?? "No comment")
        }

        return SinusData(id: user.id, values: values, labels: labels, descriptions: descriptions, sinusName: user.name, sinusTarget: user.date_name)
    }
}
