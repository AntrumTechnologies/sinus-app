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

    /**
        The view.
     */
    var body: some View {
        let manager = DataManager()

        VStack {
            HStack {
                Spacer()
                Image(systemName: "water.waves")
                    .resizable()
                    .frame().frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text("Love Waves")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .padding(.bottom)
                Spacer()
            }
            .background(ContentView.AppColor)

            TabView {
                Group {
                    ProfileView(manager: manager)
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                    GraphList(gatherer: manager, onlyFollowing: false)
                        .tabItem {
                            Label("Explore", systemImage: "list.bullet")
                        }
                    GraphList(gatherer: manager, onlyFollowing: true)
                        .tabItem {
                            Label("Following", systemImage: "checklist.checked")
                        }
                    NewUserView(manager: manager)
                        .tabItem {
                            Label("Create wave", systemImage: "water.waves")
                        }
                }
                .toolbar(.visible, for: .tabBar)
                .toolbarBackground(ContentView.AppColor, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
