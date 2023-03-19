//
//  ExternalRestRetriever.swift
//  SinuS
//
//  Created by Loe Hendriks on 18/03/2023.
//

import Foundation

class ExternalRestRetriever : RestRetrievable {
    
    public func Retrieve(request: URLRequest) async -> Data? {
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            (data, _) = try await urlSession.data(for: request)
        }
        catch {
            debugPrint("Error loading \(request.url) caused error \(error) with response \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
        
        return data
    }
}
