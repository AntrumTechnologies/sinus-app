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
    let manager = DataManager()

    // Tokens never expire so we can keep reusing the saved token
    @State private var pushActive = false
    @State private var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
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
                let res = self.manager.login(email: self.email, password: self.password)
                UserDefaults.standard.set(self.email, forKey: "email")

                if res == nil {
                    self.showAlert.toggle()
                } else {
                    // Set global authentication token.
                    ContentView.AuthenticationToken = res!.success
                    let saveSuccessful: Bool = KeychainWrapper.standard.set(ContentView.AuthenticationToken, forKey: "bearerToken")
                    if !saveSuccessful {
                        print("Could not save bearerToken")
                    }

                    // firebase login
//                    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
//                        print(result)
//                        if error != nil {
//                            print(error?.localizedDescription ?? "")
//                        } else {
//                            print("success")
//                        }
//                    }

                    self.pushActive = true
                }

            }
            .alert(isPresented: $showAlert) {
                return Alert(title: Text("Failed to Login"), message: Text("Unable to log user: \(self.email) in"), dismissButton: .default(Text("OK")))

            }
            .padding()
        }
        .background(Style.AppColor)
        .cornerRadius(5)
        .shadow(radius: 5)
        .padding()
        .foregroundColor(.white)

        NavigationLink(destination: MenuView(),
           isActive: self.$pushActive) {
             EmptyView()
        }.hidden()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
