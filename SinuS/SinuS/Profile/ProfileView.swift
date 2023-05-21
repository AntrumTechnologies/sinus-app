//
//  PersonalView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @StateObject var profileDataModel = ProfileModel(retrievable: ExternalRestRetriever())
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ProfileHeaderView(
                    name: profileDataModel.profileData.name,
                    avatar: profileDataModel.currentAvatar,
                    scaleFactor: 1)
                
                Divider()
                
                CreatedWavesView(waves: profileDataModel.createdWaves)
                
                UpdateWaveView(waves: profileDataModel.createdWaves)
                
                NewWaveView(currentUsername: profileDataModel.profileData.name)
                
                DeleteWaveView(waves: profileDataModel.createdWaves)
                
                Divider()
                
                ManageProfileView(currentUser: profileDataModel.profileData)
            }
        }
        .task {
            await self.profileDataModel.reload()
        }
        .refreshable {
            await self.profileDataModel.reload()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
