//
//  ProfileHeaderView.swift
//  SinuS
//
//  Created by Loe Hendriks on 08/01/2023.
//

import SwiftUI

struct ProfileHeaderView: View {
    let gatherer: DataManager
    let avatar: Image
    
    var name: String {
        var currentUser = self.gatherer.getCurrentUser()
        
        if (currentUser == nil) {
            return "Unknown"
        }
        
        return currentUser!.success.name
    }
    
    var body: some View {
        HStack {
            self.avatar
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Style.ThirdAppColor, lineWidth: 4)
                        .shadow(radius: 10)
                }
             
            Spacer()
            
            Text(self.name)
                .font(.system(size: 35))
                .foregroundColor(Style.ThirdAppColor)
            
            Spacer()
            
        }.padding(15)
        
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(
            gatherer: DataManager(),
            avatar: Image("Placeholder"))
    }
}
