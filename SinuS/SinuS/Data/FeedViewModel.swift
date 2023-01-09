//
//  FeedViewModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 09/01/2023.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published private var feedViewModel: GraphList
    @Published private var _isLoading: Bool = false
    private var _gatherer: DataManager
    
    init() {
        _gatherer = DataManager()
        feedViewModel = GraphList(gatherer: _gatherer, onlyFollowing: true) // Generate some default model?
    }
    
    var isLoading: Bool {
        get { return _isLoading}
    }
    
    @MainActor
    func retrieveFollowingData(_ d:Data) async {
        _isLoading = true
        print("Executing async...")
        
        do {
            let rawData = try await _gatherer.gatherUsers(postfix: "/following").sorted {
                $0.name < $1.name
            }
            _isLoading = false
            print("Done loading data")
        } catch {
            print("Error fetching data async")
        }
    }
}
