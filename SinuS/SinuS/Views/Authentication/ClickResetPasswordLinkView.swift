//
//  ClickResetPasswordLinkView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 15/01/2023.
//

import SwiftUI

struct ClickResetPasswordLinkView: View {
    @State private var nextView: Bool? = false
    
    var body: some View {
        VStack {
            Text("Password reset link sent!\nCheck your inbox to reset your password.")
                .padding()
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: LoginView(), tag: true, selection: self.$nextView) { EmptyView() }
            
            Button("Return to login") {
                self.nextView = true
            }
            .padding(EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12))
            .cornerRadius(3)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 0.5)
            )
            
            Text("")
        }
        .background(Style.AppBackground)
        .foregroundColor(Style.TextOnColoredBackground)
        .cornerRadius(5)
        .shadow(radius: 5)
        .padding()
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

struct ClickResetPasswordLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ClickResetPasswordLinkView()
    }
}
