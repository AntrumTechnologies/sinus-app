//
//  LogHelper.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 08/01/2023.
//

import Foundation

public class LogHelper {
    private static var logUrl = "https://lovewaves.antrum-technologies.nl/api/log"

    public func logMsg(level: String = "debug", message: String) {
        let parameters: [String: Any] = ["level": level, "message": message]
        let decoder = JSONDecoder()
        var request = RestApiHelper.createRequest(type: "PUT", url: LogHelper.logUrl, auth: true)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }

        let data = RestApiHelper.perfomRestCall(request: request)

        do {
            _ = try decoder.decode(AuthenticationResult.self, from: data!)
        } catch {
            print("Unexpected error: \(error).")
        }

        return
    }
}
