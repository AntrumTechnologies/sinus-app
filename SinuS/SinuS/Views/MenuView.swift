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

    init() {
        
    }

    /**
        The view.
     */
    var body: some View {
        let manager = DataManager()
        VStack {
            TabView(selection: self.$selection) {
                Group {
                    FeedView(gatherer: manager, onlyFollowing: false)
                        .tabItem {
                            Label("Explore", systemImage: "network")
                        }
                        .tag(1)
                    FeedView(gatherer: manager, onlyFollowing: true)
                        .tabItem {
                            Label("Following", systemImage: "person.2.fill")
                        }
                        .tag(2)
                    ProfileView(gatherer: manager)
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
                        Image("Logo_cropped")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundColor(.white)
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
