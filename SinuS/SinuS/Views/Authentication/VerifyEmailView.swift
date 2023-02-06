//
//  VerifyEmailView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 15/01/2023.
//

import SwiftUI

struct VerifyEmailView: View {
    var body: some View {
        VStack {
            Spacer()

            Text("Please verify your email address by clicking on the link in your email")

            Text("Resend email")

            Spacer()
        }
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

struct VerifyEmailView_Previews: PreviewProvider {
    static var previews: some View {
        VerifyEmailView()
    }
}
