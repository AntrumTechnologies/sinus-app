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
    let retrievable: RestRetrievable
    @Published var profileData: Profile
    @Published var currentAvatar: KFImage
    @Published var createdWaves: [SinusUserData] = []
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
        self.profileData = Profile(id: 0, name: "", email: "", email_verified_at: "", created_at: "", updated_at: "", avatar: "", fcm_token: "")
        
        // TODO: do not run avatar download on main thread, use a local placeholder avatar instead
        let url: URL = URL(string: "\(LoveWavesApp.baseUrl)/avatars/placeholder.jpg")!
        self.currentAvatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }
    
    func reload() async {
        var url = URL(string: "\(LoveWavesApp.baseUrl)/api/user")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        url = URL(string: "\(LoveWavesApp.baseUrl)/api/sinus/created")!
        var requestWaves = URLRequest(url: url)
        requestWaves.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestWaves.addValue("application/json", forHTTPHeaderField: "Accept")
        requestWaves.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        var data: [Data?] = [nil]
        
        Task {
            let profileDataRequest = request
            let createdWavesRequest = requestWaves
            async let profileData = self.retrievable.Retrieve(request: profileDataRequest)
            async let createdWaves = self.retrievable.Retrieve(request: createdWavesRequest)
            
            data = await [profileData, createdWaves]
            
            do {
                if (await profileData != nil) {
                    self.profileData = try await JSONDecoder().decode(Profile.self, from: profileData!)
                }
                
                if (await createdWaves != nil) {
                    self.createdWaves = try await JSONDecoder().decode([SinusUserData].self, from: createdWaves!)
                }
            } catch {
                debugPrint("Failed to retrieve data")
            }
            
            // Create avatar image
            let avatar: String = self.profileData.avatar ?? "avatars/placeholder.jpg"
            url = URL(string: "\(LoveWavesApp.baseUrl)/" + avatar)!
            self.currentAvatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
        }
    }
}
