//
//  CompareConfigurationModel.swift
//  SinuS
//
//  Created by Loe Hendriks on 26/03/2023.
//

import Foundation
import SwiftKeychainWrapper

@MainActor class CompareConfigurationModel: ObservableObject {
    @Published var compareOptions: [String]
    @Published var differenceOptions: [String]
    
    init() {
        self.compareOptions = [];
        self.differenceOptions = ["Merged", "Side by side"]
    }
    
    @MainActor func reload() async {
        
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/sinus")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        var users: [SinusUserData]
        do {
            (data, _) = try await urlSession.data(for: request)
            users = try JSONDecoder().decode([SinusUserData].self, from: data!)
            self.compareOptions = users.map { "\($0.name) - \($0.date_name)" }
            
        } catch {
            debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
        }
    }
}
