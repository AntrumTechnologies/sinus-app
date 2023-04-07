//
//  DeleteWaveModel.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/04/2023.
//

import Foundation
import SwiftKeychainWrapper

class DeleteWaveModel: ObservableObject {
    let retrievable: RestRetrievable
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
    }
    
    func deleteWave(wave_id: Int) async -> String {
        let url = "https://lovewaves.antrum-technologies.nl/api/sinus/delete"
        let parameters: [String: Any] = ["id": wave_id]
        
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
