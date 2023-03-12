//
//  PersonalModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 11/03/2023.
//

import SwiftUI
import Kingfisher
import SwiftKeychainWrapper

@MainActor class ProfileModel: ObservableObject {
    @Published var profileData: Profile
    @Published var currentAvatar: KFImage
    
    init() {
        self.profileData = Profile(id: 0, name: "", email: "", email_verified_at: "", created_at: "", updated_at: "", avatar: "", fcm_token: "")
        
        // TODO: do not run avatar download on main thread, use a local placeholder avatar instead
        let url: URL = URL(string: "https://lovewaves.antrum-technologies.nl/avatars/placeholder.jpg")!
        self.currentAvatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }
    
    @MainActor func reload() async {
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/user")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            (data, _) = try await urlSession.data(from: url)
            self.profileData = try JSONDecoder().decode(Profile.self, from: data!)
            
            // Create avatar image
            let avatar: String = self.profileData.avatar ?? "avatars/placeholder.jpg"
            let url: URL = URL(string: "https://lovewaves.antrum-technologies.nl/" + avatar)!
            self.currentAvatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
        } catch {
            debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
        }
    }
}
