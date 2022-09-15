//
//  MenuView.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/09/2022.
//

import SwiftUI

struct MenuView: View {
    
    
    var body: some View {
        let manager = DataManager()
        
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.yellow)
                
                Spacer()
                HStack {
                    // Profile button
                    NavigationLink(
                        destination: ProfileView(manager: manager),
                        label: {
                            MenuButton(image: Image(systemName: "person"), name: "Profile")
                        })
                    
                    
                    // Member list button
                    NavigationLink(
                        destination: GraphList(gatherer: manager),
                        label: {
                            MenuButton(image: Image(systemName: "list.bullet"), name: "Users")
                        })
                }
                HStack {
                    // New user button
                    NavigationLink(
                        destination: NewUserView(manager: manager),
                        label: {
                            MenuButton(image: Image(systemName: "plus"), name: "Register User")
                        })
                    
                    // admin button
                    NavigationLink(
                        destination: AdminView(),
                        label: {
                            MenuButton(image: Image(systemName: "star.fill"), name: "Admin")
                        })
                }.padding(.bottom, 15)
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
