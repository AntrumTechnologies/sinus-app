//
//  FeedView.swift
//  SinuS
//
//  Created by Loe Hendriks on 11/01/2023.
//

import SwiftUI

struct FeedView: View {
    var gatherer: DataManager
    let onlyFollowing: Bool
    @StateObject var feedDataModel = FeedModel()

    var body: some View {
        List(feedDataModel.feedModel) { userData in
            NavigationLink(
                destination: WaveView(
                    gatherer: self.gatherer,
                    user: userData),
                label: {
                    FeedItemView(userData: userData)
                })
        }
        .task {
             await self.feedDataModel.reload(onlyFollowing: self.onlyFollowing)
         }
         .refreshable {
             await self.feedDataModel.reload(onlyFollowing: self.onlyFollowing)
         }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(gatherer: DataManager(), onlyFollowing: false)
    }
}
