//
//  RegisterView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/11/2022.
//

import SwiftUI
import SwiftKeychainWrapper

struct RegisterView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var showMenu: Bool? = false

    var authenticationModel = AuthenticationModel(retrievable: ExternalRestRetriever())
    
    var body: some View {
        VStack {

            // Name
            HStack {
                Text("Name")
                Spacer()
                TextField("", text: self.$name)
                    .disableAutocorrection(true)
                    .frame(width: 190)
                    .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1.0)
                    )
            }.padding(.horizontal).padding(.top)

            // Email
            HStack {
                Text("Email")
                Spacer()
                TextField("", text: self.$email)
                    .disableAutocorrection(true)
                    .frame(width: 190)
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
                    .frame(width: 190)
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
                SecureField("", text: self.$confirmPassword)
                    .disableAutocorrection(true)
                    .frame(width: 190)
                    .padding(EdgeInsets(top: 3, leading: 6, bottom: 3, trailing: 6))
                    .cornerRadius(5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 1.0)
                    )
            }.padding(.horizontal).padding(.top)

            NavigationLink(destination: VerifyEmailView(), tag: true, selection: self.$showMenu) { EmptyView() }

            // Register button
            Button("Register") {
                let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                
                Task {
                    do {
                        let res = try await self.authenticationModel.register(
                            name: self.name,
                            email: self.email,
                            password: self.password,
                            confirmPassword: self.confirmPassword)
                        KeychainWrapper.standard.set(res!.success, forKey: "bearerToken")
                        self.showMenu = true
                    }
                    catch {
                        self.showAlert.toggle()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Failed to register"), message: Text("Unable to register user: \(self.email)"), dismissButton: .default(Text("OK")))
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
