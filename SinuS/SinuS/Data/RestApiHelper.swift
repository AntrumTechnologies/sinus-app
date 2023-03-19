//
//  RestApiHelper.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/01/2023.
//

import Foundation
import SwiftKeychainWrapper

public class RestApiHelper {
    public static func perfomRestCall(request: URLRequest) -> Data? {
        let semaphore = DispatchSemaphore.init(value: 0)
        let session = URLSession.shared
        var returnObject: Data?

        let task = session.dataTask(with: request, completionHandler: { data, _, _ -> Void in
            defer { semaphore.signal() }
            print(data)
            returnObject = data!
        })

        task.resume()
        semaphore.wait()
        return returnObject
    }

    public static func createRequest(type: String, url: String, auth: Bool = true) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = type
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        if auth {
            let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
            request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        }

        return request
    }
}
