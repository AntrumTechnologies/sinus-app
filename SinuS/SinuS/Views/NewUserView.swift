//
//  NewUserView.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/09/2022.
//

import SwiftUI

struct NewUserView: View {
    let manager: DataManager
    
    @State private var username: String = ""
    @State private var targetname: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(.yellow)
            
            Spacer()
            
            HStack {
                Text("Username:")
                Spacer()
                TextField("", text: self.$username)
                    .disableAutocorrection(true)
                    .border(Color.gray, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal, 15)
            
            HStack {
                Text("Target:")
                Spacer()
                TextField("", text: self.$targetname)
                    .disableAutocorrection(true)
                    .border(Color.gray, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal, 15)
            
            Button("Add User!") {
                self.manager.AddUser(user: self.username, target: self.targetname)
            }.foregroundColor(.yellow)
                .padding(.top)
            
            Spacer()
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView(manager: DataManager())
    }
}
