//
//  SearchModel.swift
//  SinuS
//
//  Created by Loe Hendriks on 18/04/2023.
//

import Foundation
import SwiftKeychainWrapper

@MainActor class SearchModel: ObservableObject {
    @Published var filteredUsers: [SinusUserData]
    let retrievable: RestRetrievable
    
    init(retrievable: RestRetrievable) {
        self.filteredUsers = []
        self.retrievable = retrievable
    }
    
    @MainActor func reload(filter: String) async {
        let url = URL(string: "\(LoveWavesApp.baseUrl)/api/sinus")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        var users: [SinusUserData] = []
        
        do {
            data = await self.retrievable.Retrieve(request: request)
            if (data != nil) {
                users = try JSONDecoder().decode([SinusUserData].self, from: data!)
            }
        } catch {
            if (data == nil) {
                debugPrint("Error loading \(url) caused error \(error)")
            } else {
                debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
            }
        }
        
        self.filteredUsers = users.filter{ $0.name.contains(filter) }
        
    }
    
    
}
