//
//  RegisterView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/11/2022.
//

import SwiftUI

struct RegisterView: View {
    let manager = DataManager()

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

    @State private var showingAlert = false
    static var isPasswordCorrect: Bool = false
    @State private var showButton = false

    var body: some View {
        VStack {

            // Name
            HStack {
                Text("Name:")
                Spacer()
                TextField("", text: self.$name)
                    .disableAutocorrection(true)
                    .border(Color.white, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal).padding(.top)

            // Email
            HStack {
                Text("Email:")
                Spacer()
                TextField("", text: self.$email)
                    .disableAutocorrection(true)
                    .border(Color.white, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal).padding(.top)

            // Password
            HStack {
                Text("Password:")
                Spacer()
                TextField("", text: self.$password)
                    .disableAutocorrection(true)
                    .border(Color.white, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal).padding(.top)

            // Confirm password
            HStack {
                Text("Confirm password:")
                Spacer()
                TextField("", text: self.$confirmPassword)
                    .disableAutocorrection(true)
                    .border(Color.white, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal).padding(.top)

            // Register button
            Button("Register") {
                let ar = self.manager.Register(
                    name: self.name,
                    email: self.email,
                    password: self.password,
                    confirmPassword: self.confirmPassword)

                // Set global authentication token.
                ContentView.AuthenticationToken = ar!.success

                self.showButton.toggle()
            }.padding()
        }
        .background(ContentView.AppColor)
        .cornerRadius(5)
        .shadow(radius: 5)
        .padding()
        .foregroundColor(.white)

        if self.showButton {
            NavigationLink(destination: MenuView(), label: {
                MenuButton(image: Image(systemName: "lock.open"), name: "Enter")
            })
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
