//
//  FeedViewModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 09/01/2023.
//

import SwiftUI
import SwiftKeychainWrapper

@MainActor class FeedModel: ObservableObject {
    @Published private var _feedData: [SinusUserData]
    @Published private var _isLoading: Bool = true
    let retrievable: RestRetrievable
    
    init(retrievable: RestRetrievable) {
        _feedData = []
        self.retrievable = retrievable
    }

    var isLoading: Bool {
        get { return _isLoading}
    }

    var feedModel: [SinusUserData] {
        get {return _feedData}
    }

    @MainActor func reload(onlyFollowing: Bool) async {
        _isLoading = true
        
        var postfix: String = ""
        print("Following? \(onlyFollowing)")
        if onlyFollowing {
            postfix = "/following"
        }
        
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/sinus\(postfix)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            data = await self.retrievable.Retrieve(request: request)
            if (data != nil) {
                self._feedData = try JSONDecoder().decode([SinusUserData].self, from: data!)
            }
        } catch {
            debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
        
        _isLoading = false
    }
}
