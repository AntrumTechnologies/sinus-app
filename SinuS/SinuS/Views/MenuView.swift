//
//  MenuView.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/09/2022.
//

import SwiftUI

/**
    View for the main menu of the application.
    Allows users to navigate to different parts of the application.
 */
struct MenuView: View {
    @State private var selection = 1

    private var feedViewModelFollowing: FeedViewModel
    private var feedViewModelExplore: FeedViewModel

    init() {
        self.feedViewModelFollowing = FeedViewModel()
        self.feedViewModelExplore = FeedViewModel()
    }

    /**
        The view.
     */
    var body: some View {
        let manager = DataManager()
        VStack {
            TabView(selection: self.$selection) {
                Group {
                    FeedView(feedViewModel: self.feedViewModelExplore, gatherer: manager, onlyFollowing: false)
                        .tabItem {
                            Label("Explore", systemImage: "network")
                        }
                        .tag(1)
                    FeedView(feedViewModel: self.feedViewModelFollowing, gatherer: manager, onlyFollowing: true)
                        .tabItem {
                            Label("Following", systemImage: "person.2.fill")
                        }
                        .tag(2)
                    PersonalView(gatherer: manager)
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                        .tag(3)
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(Style.AppColor, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)

            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    HStack {
                        Image(systemName: "water.waves")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        Text("Love Waves")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(.bottom)
                    }
                }
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
