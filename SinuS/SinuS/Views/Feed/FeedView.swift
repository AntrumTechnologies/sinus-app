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
    @ObservedObject var feedViewModel: FeedViewModel

    init(feedViewModel: FeedViewModel, gatherer: DataManager, onlyFollowing: Bool) {
        self.onlyFollowing = onlyFollowing
        self.feedViewModel = feedViewModel
        self.gatherer = gatherer
        print("init called")
        Task {
                feedViewModel.retrieveFollowingData(onlyFollowing: onlyFollowing)
        }

    }

    var body: some View {

        if feedViewModel.isLoading {
            // GraphList(viewModel: feedViewModel)
             LoadingView()
         } else {
             GraphList(gatherer: self.gatherer, viewModel: self.feedViewModel, onlyFollowing: self.onlyFollowing)
             // LoadingView()
         }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(feedViewModel: FeedViewModel(), gatherer: DataManager(), onlyFollowing: false)
    }
}
