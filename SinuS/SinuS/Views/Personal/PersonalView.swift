//
//  PersonalView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI
import Kingfisher

struct PersonalView: View {
    let gatherer: DataManager
    @ObservedObject var personalDataModel = PersonalModel()
    @ObservedObject var personalWavesModel = PersonalWavesModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ProfileHeaderView(
                    name: personalDataModel.personalData.name,
                    avatar: personalDataModel.currentAvatar,
                    scaleFactor: 1)
                
                Divider()
                
                CreatedRowView(gatherer: gatherer, waves: personalWavesModel.personalWaves)
                
                Divider()
                
                UpdateWaveView(manager: gatherer, waves: personalWavesModel.personalWaves)
                
                Divider()
                
                NewWaveView(manager: gatherer)
                
                Divider()
                
                ManageProfileView(manager: gatherer, currentUser: personalDataModel.personalData)
            }
        }
        .task {
            await self.personalDataModel.reload()
            await self.personalWavesModel.reload()
        }
        .refreshable {
            await self.personalDataModel.reload()
            await self.personalWavesModel.reload()
        }
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView(gatherer: DataManager())
    }
}
