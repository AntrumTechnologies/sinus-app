//
//  PersonalWavesModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 11/03/2023.
//

import SwiftUI
import SwiftKeychainWrapper

class CreatedWavesModel: ObservableObject {
    let retrievable: RestRetrievable
    @MainActor @Published var createdWaves: [SinusUserData] = []
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
    }
    
    @MainActor func reload() async {
        let url = URL(string: "\(LoveWavesApp.baseUrl)/api/sinus/created")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        var data: Data? = nil
        
        do {
            data = await self.retrievable.Retrieve(request: request)
            if (data != nil) {
                self.createdWaves = try JSONDecoder().decode([SinusUserData].self, from: data!)
            }
        } catch {
            debugPrint("Error loading: \(error) \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
    }
}
