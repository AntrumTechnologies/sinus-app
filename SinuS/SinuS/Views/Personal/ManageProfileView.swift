//
//  ManageProfileView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 07/01/2023.
//

import SwiftUI
import SwiftKeychainWrapper

struct ManageProfileView: View {
    let manager: DataManager

    var body: some View {
        VStack(alignment: .leading) {
            Text("Manage Profile:")
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
                .foregroundColor(Style.ThirdAppColor)

            HStack {
                Spacer()

                NavigationLink(destination: PreAuthenticationView(), label: {
                    MenuButton(image: Image(systemName: "figure.walk.departure"), name: "Logout")
                }).simultaneousGesture(TapGesture().onEnded {
                    KeychainWrapper.standard.remove(forKey: "bearerToken")
                })

                NavigationLink(destination: EditProfileView(gatherer: self.manager), label: {
                    MenuButton(image: Image(systemName: "gearshape.fill"), name: "Edit")
                })

                Spacer()
            }

        }
    }
}

struct ManageProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ManageProfileView(manager: DataManager())
    }
}
