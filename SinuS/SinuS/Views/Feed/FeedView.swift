//
//  FeedView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 09/01/2023.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        Task {
            await feedViewModel.followingViewData()
        }
        
        if feedViewModel.isLoading {
            LoadingView()
        } else {
            GraphList(feedWaveView: feedViewModel)
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
