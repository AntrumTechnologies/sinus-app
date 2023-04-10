//
//  ForgotPasswordView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 12/01/2023.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = UserDefaults.standard.string(forKey: "email") ?? ""
    @State private var showAlert = false
    @State private var nextView: Bool? = false
    
    var authenticationModel = AuthenticationModel(retrievable: ExternalRestRetriever())

    var body: some View {
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

            NavigationLink(destination: ClickResetPasswordLinkView(), tag: true, selection: self.$nextView) { EmptyView() }

            Button("Submit") {
                let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                
                Task {
                    do {
                        let res = try await self.authenticationModel.forgotPassword(email: self.email)
                        UserDefaults.standard.set(self.email, forKey: "forgotPasswordEmail")
                        self.nextView = true
                    }
                    catch {
                        self.showAlert.toggle()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text("Failed to request password reset link for \(self.email)"), dismissButton: .default(Text("OK")))
            }
            .padding()
        }
        .background(Style.AppBackground)
        .foregroundColor(Style.TextOnColoredBackground)
        .cornerRadius(5)
        .shadow(radius: 5)
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

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
