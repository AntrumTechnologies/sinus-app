//
//  NetworkManager.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 11/02/2023.
//

import Foundation
import SwiftKeychainWrapper

public class NetworkManager {

    public func uploadFile (fileName: String, fileData: Data?) -> URLSessionUploadTask {
        let uploadApiUrl: URL? = URL(string: "\(LoveWavesApp.baseUrl)/api/user/update")

        // Generate a unique boundary string using a UUID.
        let uniqueBoundary = UUID().uuidString

        var bodyData = Data()

        // Add the multipart/form-data raw http body data.
        bodyData.append("\r\n--\(uniqueBoundary)\r\n".data(using: .utf8)!)
        bodyData.append("Content-Disposition: form-data; name=\"avatar\"; filename=\"\(fileName)\"\r\n"
            .data(using: .utf8)!)
        bodyData.append("Content-Type: image/jpg\r\n\r\n".data(using: .utf8)!)

        // Add the zip file data to the raw http body data.
        bodyData.append(fileData!)

        // End the multipart/form-data raw http body data.
        bodyData.append("\r\n--\(uniqueBoundary)--\r\n".data(using: .utf8)!)

        let urlSessionConfiguration = URLSessionConfiguration.default

        let urlSession
            = URLSession(
                configuration: urlSessionConfiguration)

        var urlRequest = URLRequest(url: uploadApiUrl!)

        // Set Content-Type Header to multipart/form-data with the unique boundary.
        urlRequest.setValue("multipart/form-data; boundary=\(uniqueBoundary)", forHTTPHeaderField: "Content-Type")
        // Set bearer token
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        urlRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

        urlRequest.httpMethod = "POST"

        let retval = urlSession.uploadTask(
            with: urlRequest,
            from: bodyData,
            completionHandler: { (responseData, response, error) in
                // Check on some response headers (if it's HTTP)
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200..<300:
                        print("Success")
                    case 400..<500:
                        print("Request error")
                    case 500..<600:
                        print("Server error")
                    case let otherCode:
                        print("Other code: \(otherCode)")
                    }
                }

                // Do something with the response data
                if let
                    responseData = responseData,
                   let responseString = String(data: responseData, encoding: String.Encoding.utf8) {
                    print("Server Response:")
                    print(responseString)
                }

                // Do something with the error
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        )
        retval.resume()

        return retval
    }
}
