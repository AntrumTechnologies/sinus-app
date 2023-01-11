//
//  RegisterView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/11/2022.
//

import SwiftUI
import SwiftKeychainWrapper

struct RegisterView: View {
    let manager = DataManager()

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false

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
                let authenticationResult = self.manager.register(
                    name: self.name,
                    email: self.email,
                    password: self.password,
                    confirmPassword: self.confirmPassword)

                if authenticationResult == nil {
                    self.showAlert.toggle()
                } else {
                    // Set global authentication token.
                    ContentView.AuthenticationToken = authenticationResult!.success
                    let saveSuccessful: Bool = KeychainWrapper.standard.set(ContentView.AuthenticationToken, forKey: "bearerToken", isSynchronizable: true)
                    if !saveSuccessful {
                        print("Could not save bearerToken")
                    }
                    self.showButton.toggle()
                }

            }
            .alert(isPresented: $showAlert) {
                return Alert(title: Text("Failed to Register"), message: Text("Unable to register user: \(self.email)"), dismissButton: .default(Text("OK")))
            }
            .padding()
        }
        .background(Style.AppColor)
        .cornerRadius(5)
        .shadow(radius: 5)
        .padding()
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    HStack {
                        Image(systemName: "water.waves")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.white)
                            .padding(.bottom)
                        Text("Love Waves")
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .padding(.bottom)
                    }
                }
            }
        }

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
