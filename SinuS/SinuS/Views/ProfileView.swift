//
//  ProfileView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import SwiftUI

struct ProfileView: View {
    let manager: DataManager
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var value = 50.0
    @State private var isEditing = false
    @State private var date = Date()
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person.circle").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.yellow)
            Spacer()
            HStack {
                Text("Username:")
                Spacer()
                TextField("Name", text: self.$username)
                    .disableAutocorrection(true)
                    .border(Color.gray, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal, 15)
            
            HStack {
                Text("Password:")
                Spacer()
                TextField("", text: self.$password)
                    .disableAutocorrection(true)
                    .border(Color.gray, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal, 15)
            
            HStack {
                Text("Value:")
                Spacer()
                Slider(
                    value: self.$value,
                    in: 0...100,
                    step: 1).foregroundColor(.yellow)
                Text("\(Int(self.value))")
            }.padding(.horizontal, 15)
            
            HStack {
                DatePicker(selection: $date, displayedComponents: [.date], label: { Text("Date:") })
            }.padding(.horizontal, 15)
            
            
            Button("Update") {
                let update = SinusUpdate(name: self.username, password: self.password, value: Int(self.value), date: self.date)
                manager.SendData(data: update)
            }.foregroundColor(.yellow)
            Spacer()
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(manager: DataManager())
    }
}
