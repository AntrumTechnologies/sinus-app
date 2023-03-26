//
//  ClickResetPasswordLinkView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 15/01/2023.
//

import SwiftUI

struct ClickResetPasswordLinkView: View {
    var body: some View {
        VStack {
            Text("Please click on the link sent to your email to reset your password. Then go back to login again.").padding()
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

struct ClickResetPasswordLinkView_Previews: PreviewProvider {
    static var previews: some View {
        ClickResetPasswordLinkView()
    }
}
