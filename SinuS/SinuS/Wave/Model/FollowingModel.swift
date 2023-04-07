//
//  FollowingModel.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/04/2023.
//

import Foundation
import SwiftKeychainWrapper

@MainActor class FollowingModel: ObservableObject {
    @Published var isFollowing: Bool
    private let logger = LogHelper()
    
    init() {
        self.isFollowing = true
    }
    
    @MainActor func followingAction(user: SinusUserData) async {
        var request: URLRequest
        
        if (self.isFollowing)
        {
            // unfollow user
            let urlString = "https://lovewaves.antrum-technologies.nl/api/unfollow"
            request = RestApiHelper.createRequest(type: "PUT", url: urlString)
            let parameters: [String: Any] = ["user_id_to_unfollow": user.user_id ]
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
        else{
            // follow user
            let urlString = "https://lovewaves.antrum-technologies.nl/api/follow"
            request = RestApiHelper.createRequest(type: "PUT", url: urlString)
            let parameters: [String: Any] = ["user_id_to_follow": user.user_id ]
            
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print(error.localizedDescription)
                return
            }
        }
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            (data, _) = try await urlSession.data(for: request)
        } catch {
            debugPrint("Error loading \(request.url) caused error \(error) with response \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
        
        await self.reload(user: user)
    }
    

    @MainActor func reload(user: SinusUserData) async {
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/sinus/\(user.id)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        var user: SinusUserData?
        do {
            (data, _) = try await urlSession.data(for: request)
            print("data \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
            user = try JSONDecoder().decode(SinusUserData.self, from: data!)
        } catch {
            debugPrint("Error loading \(request.url) caused error \(error) with response \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
        if (user == nil){
            self.isFollowing = false;
            self.logger.logMsg(level: "Error", message: "Could not retrieve current user from list of users to check following flag.")
            
        }
        else{
            self.isFollowing = user!.following ?? false
            print("following: \(self.isFollowing)")
        }
    }
}
