//
//  FeedView.swift
//  SinuS
//
//  Created by Loe Hendriks on 11/01/2023.
//

import SwiftUI

struct FeedView: View {
    let onlyFollowing: Bool
    @StateObject var feedDataModel = FeedModel(retrievable: ExternalRestRetriever())

    var body: some View {
        VStack {
            
            if (feedDataModel.feedModel.count == 0) {
                ProgressView().foregroundColor(Style.AppColor)
            } else {
                List(feedDataModel.feedModel) { userData in
                    NavigationLink(
                        destination: WaveView(user: userData),
                        label: {
                            FeedItemView(userData: userData)
                        })
                }
                .padding(.top)
                .background(Style.AppBackground)
                .scrollContentBackground(.hidden)
            }
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
        FeedView(onlyFollowing: false)
    }
}
