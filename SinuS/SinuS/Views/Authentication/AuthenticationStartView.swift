//
//  AuthenticationStartView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/11/2022.
//

import SwiftUI

struct AuthenticationStartView: View {
    @State private var selection = Tab.feed

    private var feedViewModelExplore: FeedViewModel

    private enum Tab: Hashable {
            case feed
            case login
            case register
        }

    init() {
        self.feedViewModelExplore = FeedViewModel()
    }

    var body: some View {
        let manager = DataManager()

        VStack {
            TabView(selection: self.$selection) {
                Group {
                    FeedView(feedViewModel: self.feedViewModelExplore, gatherer: manager, onlyFollowing: false)
                        .tabItem {
                            Label("Explore", systemImage: "network")
                        }
                        .tag(Tab.feed)
                    RegisterView()
                        .tabItem {
                            Label("Register", systemImage: "person.fill.badge.plus")
                        }
                        .tag(Tab.register)
                    LoginView()
                        .tabItem {
                            Label("Login", systemImage: "person.badge.key.fill")
                        }
                        .tag(Tab.login)
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Style.AppColor, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            }
        }
    }
}

struct AutenticationStartView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationStartView()
    }
}
