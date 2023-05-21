//
//  NewWaveModel.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/04/2023.
//

import Foundation

@MainActor class NewWaveModel: ObservableObject {
    let retrievable: RestRetrievable
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
    }
    
    @MainActor func createNewWave(name: String) async -> String {
        var url = "https://www.lovewaves.antrum-technologies.nl/api/sinus"
        let parameters: [String: Any] = ["wave_name": name]
        var request = RestApiHelper.createRequest(type: "PUT", url: url)

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return error.localizedDescription
        }

        
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            data = await self.retrievable.Retrieve(request: request)
        }
        catch {
            debugPrint("Error loading \(request.url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
        }
        
        let message = String(bytes: data!, encoding: .utf8) ?? ""
        return message.replacingOccurrences(of: "\"", with: "")
        
    }
}
