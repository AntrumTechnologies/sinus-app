//
//  ResetPasswordView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 15/01/2023.
//

import SwiftUI
import SwiftKeychainWrapper

struct ResetPasswordView: View {
    @State private var token: String = ""
    @State private var email: String = UserDefaults.standard.string(forKey: "forgotPasswordEmail") ?? ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var showLogin: Bool? = false

    var authenticationModel = AuthenticationModel(retrievable: ExternalRestRetriever())
    
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
                        .frame(width: 220)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        )
                }.padding(.horizontal).padding(.top)
            }

            // Password
            HStack {
                Text("New password")
                Spacer()
                TextField("", text: self.$password)
                    .disableAutocorrection(true)
                    .frame(width: 220)
                    .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1.0)
                    )
            }.padding(.horizontal).padding(.top)

            // Confirm password
            HStack {
                Text("Confirm password")
                Spacer()
                TextField("", text: self.$confirmPassword)
                    .disableAutocorrection(true)
                    .frame(width: 220)
                    .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1.0)
                    )
            }.padding(.horizontal).padding(.top)

            NavigationLink(destination: ContentView(), tag: true, selection: self.$showLogin) { EmptyView() }

            Button("Submit") {
                let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                
                Task {
                    do {
                        let res = try await self.authenticationModel.resetPassword(
                            token: self.token,
                            email: self.email,
                            password: self.password,
                            confirmPassword: self.confirmPassword)
                        KeychainWrapper.standard.set(res!.success, forKey: "bearerToken")
                        self.showLogin = true
                    }
                    catch {
                        self.showAlert.toggle()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                return Alert(title: Text("Failed to reset password"), message: Text("Unable to reset password for \(self.email)"), dismissButton: .default(Text("OK")))
            }
            .padding()
        }
        .background(Style.AppBackground)
        .foregroundColor(Style.TextOnColoredBackground)
        .cornerRadius(5)
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    HStack {
                        Image("Logo_cropped")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundColor(.white)
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
