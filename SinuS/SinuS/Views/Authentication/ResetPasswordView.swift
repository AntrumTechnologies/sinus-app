//
//  ResetPasswordView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 15/01/2023.
//

import SwiftUI
import SwiftKeychainWrapper

struct ResetPasswordView: View {
    let manager = DataManager()

    @State private var token: String = ""
    @State private var email: String = UserDefaults.standard.string(forKey: "forgotPasswordEmail") ?? ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var showLogin: Bool? = false

    var body: some View {
        VStack {
            if self.email != "" {
                // Show email address of which reset password email was sent to
                HStack {
                    Text("Email")
                    Spacer()
                    TextField("", text: self.$email)
                        .disabled(true)
                        .disableAutocorrection(true)
                        .border(Color.white, width: 0.5)
                        .frame(width: 220)
                }.padding(.horizontal).padding(.top)
            }

            // Password
            HStack {
                Text("New password")
                Spacer()
                TextField("", text: self.$password)
                    .disableAutocorrection(true)
                    .border(Color.white, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal).padding(.top)

            // Confirm password
            HStack {
                Text("Confirm password")
                Spacer()
                TextField("", text: self.$confirmPassword)
                    .disableAutocorrection(true)
                    .border(Color.white, width: 0.5)
                    .frame(width: 220)
            }.padding(.horizontal).padding(.top)

            NavigationLink(destination: LoginView(), tag: true, selection: self.$showLogin) { EmptyView() }

            Button("Submit") {
                let authenticationResult = self.manager.resetPassword(
                    token: self.token,
                    email: self.email,
                    password: self.password,
                    confirmPassword: self.confirmPassword)

                if authenticationResult == nil {
                    self.showAlert.toggle()
                } else {
                    UserDefaults.standard.removeObject(forKey: "forgotPasswordEmail")

                    // Set global authentication token.
                    ContentView.AuthenticationToken = authenticationResult!.success
                    let saveSuccessful: Bool = KeychainWrapper.standard.set(ContentView.AuthenticationToken, forKey: "bearerToken")
                    if !saveSuccessful {
                        print("Could not save bearerToken")
                    }

                    self.showLogin = true
                }

            }
            .alert(isPresented: $showAlert) {
                return Alert(title: Text("Failed to reset password"), message: Text("Unable to reset password: \(self.email)"), dismissButton: .default(Text("OK")))
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
    }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView()
    }
}
