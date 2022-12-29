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
        TabView {
            ProfileView(manager: manager)
                .tabItem{
                    Label("Profile", systemImage: "person")
                }
            GraphList(gatherer: manager)
                .tabItem{
                    Label("Explore", systemImage: "list.bullet")
                }
            NewUserView(manager: manager)
                .tabItem{
                    Label("Create Wave", systemImage: "water.waves")
                }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
