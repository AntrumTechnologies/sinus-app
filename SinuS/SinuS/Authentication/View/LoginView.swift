//
//  LoginView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/11/2022.
//

import SwiftUI
import SwiftKeychainWrapper
import Firebase

struct LoginView: View {

    @State private var showMenu: Bool? = false
    @State private var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @State private var password: String = ""
    @State private var showAlert = false
    
    var authenticationModel = AuthenticationModel(retrievable: ExternalRestRetriever())

    var body: some View {
        VStack {
            Spacer()

            VStack {
                // Email
                HStack {
                    Text("Email")
                    Spacer()
                    TextField("", text: self.$email)
                        .disableAutocorrection(true)
                        .frame(width: 220)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        )
                }.padding(.horizontal).padding(.top)

                // Password
                HStack {
                    Text("Password")
                    Spacer()
                    SecureField("", text: self.$password)
                        .disableAutocorrection(true)
                        .frame(width: 220)
                        .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(lineWidth: 1.0)
                        )
                }.padding(.horizontal).padding(.top)

                NavigationLink(destination: MenuView(), tag: true, selection: self.$showMenu) { EmptyView() }

                // Login Button
                Button("Login") {
                    let res = self.authenticationModel.login(email: self.email, password: self.password)
                    UserDefaults.standard.set(self.email, forKey: "email")

                    if res == nil {
                        self.showAlert.toggle()
                    } else {
                        // Set global authentication token.
                        let saveSuccessful: Bool = KeychainWrapper.standard.set(
                            res!.success,
                            forKey: "bearerToken")
                        if !saveSuccessful {
                            print("Could not save bearerToken")
                        }

                        self.showMenu = true
                    }
                }
                .alert(isPresented: $showAlert) {
                    return Alert(title: Text("Failed to login"),
                                 message: Text(self.email),
                                 dismissButton: .default(Text("OK")))

                }
                .padding()
            }
            .background(Style.AppBackground)
            .foregroundColor(Style.TextOnColoredBackground)
            .cornerRadius(5)
            .shadow(radius: 5)
            .padding()
            .foregroundColor(.white)

            NavigationLink(destination: ForgotPasswordView(), label: {
                Text("Forgot password?")
            })
            .foregroundColor(Style.AppColor)
            .padding()

            Spacer()

            VStack {
                NavigationLink(destination: RegisterView(), label: {
                    MenuButton(image: Image(systemName: "person.fill.badge.plus"), name: "Register")
                })
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
