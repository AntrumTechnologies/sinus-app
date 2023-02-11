//
//  NetworkManager.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 11/02/2023.
//

import Foundation
import SwiftUI

public class NetworkManager: NSObject {
    static let shared = NetworkManager()
        
    public override init() {}
    
    public func uploadFile (fileName: String, fileData: Data?) async throws -> (Data, URLResponse) {
        let uploadApiUrl: URL? = URL(string: "https://lovewaves.antrum-technologies.nl/api/user/update")

        // Generate a unique boundary string using a UUID.
        let uniqueBoundary = UUID().uuidString

        var bodyData = Data()

        // Add the multipart/form-data raw http body data.
        bodyData.append("\r\n--\(uniqueBoundary)\r\n".data(using: .utf8)!)
        bodyData.append("Content-Disposition: form-data; avatar=\"\(fileName)\"\r\n".data(using: .utf8)!)
        // bodyData.append("Content-Type: image/jpg\r\n\r\n".data(using: .utf8)!)

        // Add the zip file data to the raw http body data.
        bodyData.append(fileData!)

        // End the multipart/form-data raw http body data.
        bodyData.append("\r\n--\(uniqueBoundary)--\r\n".data(using: .utf8)!)

        let urlSessionConfiguration = URLSessionConfiguration.default

        let urlSession
            = URLSession(
                configuration: urlSessionConfiguration,
                delegate: self,
                delegateQueue: nil)

        var urlRequest = URLRequest(url: uploadApiUrl!)

        // Set Content-Type Header to multipart/form-data with the unique boundary.
        urlRequest.setValue("multipart/form-data; boundary=\(uniqueBoundary)", forHTTPHeaderField: "Content-Type")

        urlRequest.httpMethod = "POST"
        
        let (data, urlResponse) = try await urlSession.upload(
            for: urlRequest,
            from: bodyData,
            delegate: nil
        )

        return (data, urlResponse)
    }
}

extension NetworkManager: URLSessionTaskDelegate {
    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didSendBodyData bytesSent: Int64,
        totalBytesSent: Int64,
        totalBytesExpectedToSend: Int64) {

        print("fractionCompleted  : \(Int(Float(totalBytesSent) / Float(totalBytesExpectedToSend) * 100))")
    }

}
