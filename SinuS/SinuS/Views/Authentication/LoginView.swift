//
//  LoginView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/11/2022.
//

import SwiftUI

struct LoginView: View {
    let manager = DataManager()

    @State private var showButton = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false

    var body: some View {
        VStack {
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
                SecureField("", text: self.$password)
                    .disableAutocorrection(true)
                    .border(Color.white, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal).padding(.top)

            // Login Button
            Button("Login") {
                let ar = self.manager.login(email: self.email, password: self.password)

                if ar == nil {
                    self.showAlert.toggle()
                } else {
                    // Set global authentication token.
                    ContentView.AuthenticationToken = ar!.success

                    self.showButton.toggle()
                }

            }
            .alert(isPresented: $showAlert) {
                return Alert(title: Text("Failed to Login"), message: Text("Unable to log user: \(self.email) in"), dismissButton: .default(Text("OK")))

            }
            .padding()
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
