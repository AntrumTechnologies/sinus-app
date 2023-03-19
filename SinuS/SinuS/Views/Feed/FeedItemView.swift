//
//  Concept1.swift
//  SinuS
//
//  Created by Loe Hendriks on 25/02/2023.
//

import SwiftUI

struct FeedItemView: View {
    var userData: SinusUserData
    @StateObject var feedItemModel = FeedItemModel(retrievable: ExternalRestRetriever())

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                self.feedItemModel.avatar
                    .resizable()
                    .frame(
                        width: 50,
                        height: 50)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Style.TextOnColoredBackground, lineWidth: 4)
                            .shadow(radius: 10)
                    }
                    .padding()
                
                Text(self.userData.name)
                Image(systemName: "arrow.right")
                    .foregroundColor(Style.AppColor)
                Text(self.userData.date_name)
                Spacer()
            }
            .foregroundColor(Style.TextOnColoredBackground)
            WavePreviewView(
                percentage: self.feedItemModel.percentage,
                description: self.feedItemModel.waveData.descriptions.last ?? "",
                hasData: self.feedItemModel.chartPoints.count > 0)
        }
        .task {
            await self.feedItemModel.reload(userData: userData)
        }
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView(userData: SinusUserData(
            id: 1,
            name: "Name",
            user_id: 1,
            date_name: "Target",
            created_at: "",
            updated_at: "",
            deleted_at: "",
            archived: 0,
            avatar: "",
            following: false))
    }
}
