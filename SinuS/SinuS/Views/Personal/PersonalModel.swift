//
//  PersonalModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 11/03/2023.
//

import SwiftUI
import Kingfisher

@MainActor class PersonalModel: ObservableObject {
    @Published var personalData: Personal
    @Published var currentAvatar: KFImage
    
    init() {
        self.personalData = Personal(id: 0, name: "", email: "", email_verified_at: "", created_at: "", updated_at: "", avatar: "", fcm_token: "")
        
        let url: URL = URL(string: "https://lovewaves.antrum-technologies.nl/avatars/placeholder.jpg")!
        self.currentAvatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }
    
    @MainActor func reload() async {
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/user")!
        let urlSession = URLSession.shared
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            self.personalData = try JSONDecoder().decode(Personal.self, from: data)
            
            // Create avatar image
            let avatar: String = self.personalData.avatar ?? "avatars/placeholder.jpg"
            let url: URL = URL(string: "https://lovewaves.antrum-technologies.nl/" + avatar)!
            self.currentAvatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
        } catch {
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}
