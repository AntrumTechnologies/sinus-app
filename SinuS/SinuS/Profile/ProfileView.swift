//
//  PersonalView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    @ObservedObject var profileDataModel = ProfileModel()
    @ObservedObject var createdWavesModel = CreatedWavesModel(retrievable: ExternalRestRetriever())
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ProfileHeaderView(
                    name: profileDataModel.profileData.name,
                    avatar: profileDataModel.currentAvatar,
                    scaleFactor: 1)
                
                Divider()
                
                CreatedWavesView(waves: createdWavesModel.createdWaves)
                
                Divider()
                
                UpdateWaveView(waves: createdWavesModel.createdWaves)
                
                Divider()
                
                NewWaveView(currentUsername: profileDataModel.profileData.name)
                
                DeleteWaveView(waves: createdWavesModel.createdWaves)
                
                Divider()
                
                ManageProfileView(currentUser: profileDataModel.profileData)
            }
        }
        .task {
            await self.profileDataModel.reload()
            await self.createdWavesModel.reload()
        }
        .refreshable {
            await self.profileDataModel.reload()
            await self.createdWavesModel.reload()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
