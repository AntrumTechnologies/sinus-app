//
//  FeedView.swift
//  SinuS
//
//  Created by Loe Hendriks on 11/01/2023.
//

import SwiftUI

struct FeedView: View {
    let onlyFollowing: Bool
    let loggedIn: Bool
    @StateObject var feedDataModel = FeedModel(retrievable: ExternalRestRetriever())

    var body: some View {
        VStack {
            if (loggedIn) {
                HStack {
                    if (self.onlyFollowing){
                        Text("Following").foregroundColor(Style.TextOnColoredBackground)
                        Text("Explore").foregroundColor(.gray)
                    }
                    else{
                        Text("Following").foregroundColor(.gray)
                        Text("Explore").foregroundColor(Style.TextOnColoredBackground)
                    }
                }
                .padding(.top)
            }
            
            if (feedDataModel.feedModel.count == 0) {
                Text("Nothing here").foregroundColor(Style.AppColor)
            } else {
                List(feedDataModel.feedModel) { userData in
                    NavigationLink(
                        destination: WaveView(user: userData),
                        label: {
                            FeedItemView(userData: userData)
                        })
                }
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
        FeedView(onlyFollowing: false, loggedIn: true)
    }
}
