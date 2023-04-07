//
//  PersonalWavesModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 11/03/2023.
//

import SwiftUI
import SwiftKeychainWrapper

class CreatedWavesModel: ObservableObject {
    @MainActor @Published var createdWaves: [SinusUserData] = []
    
    @MainActor func reload() async {
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/sinus/created")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            (data, _) = try await urlSession.data(for: request)
            self.createdWaves = try JSONDecoder().decode([SinusUserData].self, from: data!)
        } catch {
            debugPrint("Error loading: \(error) \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
    }
}
