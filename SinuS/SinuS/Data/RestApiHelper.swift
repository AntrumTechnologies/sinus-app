//
//  RestApiHelper.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/01/2023.
//

import Foundation


public func PerfomRestCall(request: URLRequest) -> AuthenticationResult? {
    let semaphore = DispatchSemaphore.init(value: 0)
    
    let session = URLSession.shared
    
    let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
        do {
            if let httpResponse = response as? HTTPURLResponse {
                ContentView.Cookie = httpResponse.value(forHTTPHeaderField: "Set-Cookie") ?? ""
            }
            
            defer { semaphore.signal() }
            return data
            //result = try decoder.decode(AuthenticationResult.self, from: data!)
        } catch {
            print(error.localizedDescription)
        }
    })
    
    task.resume()
    semaphore.wait()
    return nil
}
