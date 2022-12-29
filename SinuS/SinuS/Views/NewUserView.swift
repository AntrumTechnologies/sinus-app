//
//  NewUserView.swift
//  SinuS
//
//  Created by Loe Hendriks on 15/09/2022.
//

import SwiftUI

/**
    View which allows users to create new graphs.
 */
struct NewUserView: View {
    let manager: DataManager
    
    @State private var username: String = ""
    @State private var targetname: String = ""
    @State private var showingAlert = false
    
    /**
        The view.
     */
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
                .foregroundColor(ContentView.AppColor)
            
            Spacer()
            
            VStack {
                HStack {
                    Text("Username:")
                    Spacer()
                    TextField("", text: self.$username)
                        .disableAutocorrection(true)
                        .border(Color.white, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal).padding(.top)
                
                HStack {
                    Text("Target:")
                    Spacer()
                    TextField("", text: self.$targetname)
                        .disableAutocorrection(true)
                        .border(Color.white, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal)
                
                Button("Add User!") {
                    self.manager.AddUser(user: self.username, target: self.targetname)
                    
                    // Add initial point at zero
                    self.manager.SendData(data: SinusUpdate(name: self.username, password: "", value: 0, date: Date()))
                }
                .padding()
                .alert("User added!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .foregroundColor(.white)
            .background(ContentView.AppColor)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()
            
            
            Spacer()
        }
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView(manager: DataManager())
    }
}
