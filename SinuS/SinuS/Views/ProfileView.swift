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
    @State private var value = 50.0
    @State private var isEditing = false
    @State private var date = Date()
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Image(systemName: "person.circle").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red.opacity(0.5))
            
            Spacer()
            
            VStack{
                HStack {
                    Text("Username:")
                    Spacer()
                    TextField("", text: self.$username)
                        .disableAutocorrection(true)
                        .border(Color.white, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal).padding(.top)
                
                HStack {
                    DatePicker(selection: $date, displayedComponents: [.date], label: { Text("Date:") })
                }.padding(.horizontal)
                
                HStack {
                    Text("Value:")
                    Spacer()
                    Slider(
                        value: self.$value,
                        in: 0...100,
                        step: 1).foregroundColor(.yellow)
                        .frame(width: 220)
                }.padding(.horizontal)
                
                HStack {
                    Text("\(Int(self.value))")
                }.font(.system(size: 50))
                
                Button("Update") {
                    let update = SinusUpdate(name: self.username, password: "", value: Int(self.value), date: self.date)
                    manager.SendData(data: update)
                    showingAlert = true
                }
                .padding()
                .alert("Value added!", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
            }
            .background(.red.opacity(0.5))
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()
            .foregroundColor(.white)
    
            
            Spacer()
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(manager: DataManager())
    }
}
