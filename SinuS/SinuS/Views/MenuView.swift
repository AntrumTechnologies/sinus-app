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
                Text("Love Wave")
                    .font(.system(size: 50))
                    .foregroundColor(.red.opacity(0.5))
                    
                Image(systemName: "chart.line.uptrend.xyaxis.circle.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.red.opacity(0.5))
                
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
