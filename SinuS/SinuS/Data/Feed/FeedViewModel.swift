//
//  FeedViewModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 09/01/2023.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published private var _feedModel: [SinusUserData]
    @Published private var _isLoading: Bool = true
    private var _gatherer: DataManager

    init() {
        _gatherer = DataManager()
        _feedModel = []
    }

    var isLoading: Bool {
        get { return _isLoading}
    }

    var feedModel: [SinusUserData] {
        get {return _feedModel}
    }

    @MainActor
    func retrieveFollowingData(onlyFollowing: Bool) {
        _isLoading = true
        print("Executing async...")

        do {
            var postfix: String = ""
            print("only \(onlyFollowing)")
            if onlyFollowing {
                postfix = "/following"
            }

            let rawData = _gatherer.gatherUsers(postfix: postfix).sorted {
                $0.name < $1.name
            }
            _feedModel = rawData
            _isLoading = false
            print("Done loading data")
        } catch {
            print("Error fetching data async")
        }
    }
}
