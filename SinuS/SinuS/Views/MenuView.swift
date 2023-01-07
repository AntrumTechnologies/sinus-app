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
    @State private var selection = 2
    
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
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text("Love Waves")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .padding(.bottom)
                Spacer()
            }
            .background(ContentView.AppColor)

            TabView(selection: self.$selection) {
                Group {
                    GraphList(gatherer: manager, onlyFollowing: false)
                        .tabItem {
                            Label("Explore", systemImage: "list.bullet")
                        }
                        .tag(1)
                    GraphList(gatherer: manager, onlyFollowing: true)
                        .tabItem {
                            Label("Following", systemImage: "checklist.checked")
                        }
                        .tag(2)
                    PersonalView(gatherer: manager)
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                        .tag(3)
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
