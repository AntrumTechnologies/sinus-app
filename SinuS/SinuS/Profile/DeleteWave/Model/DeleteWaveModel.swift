//
//  DeleteWaveModel.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/04/2023.
//

import Foundation
import SwiftKeychainWrapper

@MainActor class DeleteWaveModel: ObservableObject {
    let retrievable: RestRetrievable
    public var waves: [SinusUserData]
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
        self.waves = []
    }
    
    func setWaves(waves: [SinusUserData]) {
        self.waves = waves
        print("number of waves: \(waves.count)")
    }
    
    @MainActor func reload(waves: [SinusUserData]) async {
        self.waves = waves
        print("number of waves: \(waves.count)")
    }
    
    @MainActor func deleteWave(wave_id: Int) async -> String {
        let url = "\(LoveWavesApp.baseUrl)/api/sinus/delete"
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
            data = try await self.retrievable.Retrieve(request: request)
        }
        catch {
            debugPrint("Error loading \(request.url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
        }
        
        self.waves = waves.filter {$0.id != wave_id}
        
        let message = String(bytes: data!, encoding: .utf8) ?? ""
        return message.replacingOccurrences(of: "\"", with: "")
    }
}
