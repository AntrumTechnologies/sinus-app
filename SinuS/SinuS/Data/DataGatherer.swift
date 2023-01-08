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
private struct GraphDataPoint: Codable {
    let date: String
    let value: Int
    let deleted_at: String?
    let latitude: Double?
    let longitude: Double?
    let tags: String
}

/**
    Class responsible for storing and retrieve data to and from the backend.
 */
public class DataManager {
    // endpoints
    private static var userUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinus"
    private static var dataUrl = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/sinusvalue/"

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
        let registerUrl = "https://lukassinus2.vanbroeckhuijsenvof.nl/api/register?"
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
        let loginUrl = "https://lukassinus2.vanbroeckhuijsenvof.nl/api/login?"
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

    public func getCurrentUser() -> TotalUserData?{
        let url = "https://lukassinus2.vanbroeckhuijsenvof.nl/api/user"
        let decoder = JSONDecoder()
        var request = RestApiHelper.createRequest(type: "GET", url: url, auth: true)
        
        var result: TotalUserData?
        let data = RestApiHelper.perfomRestCall(request: request)
        
        print(String(decoding: data!, as: UTF8.self))
    
        do {
            result = try decoder.decode(TotalUserData.self, from: data!)
        } catch {
            print("Unexpected error: \(error).")
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
    public func sendData(data: SinusUpdate) {
        print("SendData")
        let sem = DispatchSemaphore.init(value: 0)

        if users.count < 1 {
            _ = self.gatherUsers()
        }

        if let user = self.users.first(where: { user in
            return user.name == data.name
        }) {
            let url = "https://lukassinus2.vanbroeckhuijsenvof.nl/api/sinusvalue"

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
            let task = session.dataTask(with: request, completionHandler: { _, response, error -> Void in
                defer { sem.signal() }
                print(response as Any)

                if error.debugDescription != "" {
                    let errMsg = "Unable to sendData: \(error.debugDescription)"
                    self.logHelper.logMsg(level: "error", message: errMsg)
                    print(errMsg)
                }
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
                defer { sem.signal() }
                internalUsers = try decoder.decode([SinusUserData].self, from: data!)
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

    public func unFollowUser(user_id: Int) {
        let urlString = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/unfollow"
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
        let urlString = "https://www.lukassinus2.vanbroeckhuijsenvof.nl/api/follow"
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
        points.forEach { point in
            values.append(point.value)
            labels.append(point.date)
        }

        return SinusData(id: user.id, values: values, labels: labels, sinusName: user.name, sinusTarget: user.date_name)
    }
}
