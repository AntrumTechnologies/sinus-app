//
//  ContentViewModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 01/04/2023.
//

import SwiftUI
import SwiftKeychainWrapper

@MainActor class ContentViewModel: ObservableObject {
    let retrievable: RestRetrievable
    
    @Published var contentViewModel: Content
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
        self.contentViewModel = Content(loggedIn: false, user: Profile(id: 0, name: "", email: "", email_verified_at: "", created_at: "", updated_at: "", avatar: "", fcm_token: ""))
    }
    
    @MainActor func reload() async {
        contentViewModel.loggedIn = false // Prevent loggedIn always being true after running once
        // Attempt to retrieve user data in order to verify whether user is logged in
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/user")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        print("Bearer \(bearerToken)")
        var data: Data? = nil
        
        do {
            data = await self.retrievable.Retrieve(request: request)
            contentViewModel.user = try JSONDecoder().decode(Profile.self, from: data ?? Data())
            // Successfully retrieved user data, thus user is logged in
            print("User is logged in")
            contentViewModel.loggedIn = true
        } catch {
            debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
        
        // Check if FCM token is up-to-date and if not update it
        let deviceToken: String = KeychainWrapper.standard.string(forKey: "deviceToken") ?? ""
        if (deviceToken != "" && contentViewModel.user.fcm_token != deviceToken) {
            print("Updating FCM token...")
            request = URLRequest(url: URL(string: "https://lovewaves.antrum-technologies.nl/api/user/update")!)
            request.httpMethod = "PUT"
            
            let parameters: [String: Any] = ["fcm_token": deviceToken]

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print("Error updating FCM token due to \(error.localizedDescription)")
                return
            }
            
            var data: Data? = nil
            
            do {
                data = await self.retrievable.Retrieve(request: request)
                let userData = try JSONDecoder().decode(Profile.self, from: data ?? Data())
            } catch {
                debugPrint("Updating FCM token caused error \(error) with response \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
            }
        } else {
            print("FCM token is up-to-date")
        }
    }
}
