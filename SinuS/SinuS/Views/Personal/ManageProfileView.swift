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
    let currentUser: Personal

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.fill")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Manage profile")
                    .font(.headline)
                    .padding(.top, 5)
            }.foregroundColor(Style.AppColor)

            HStack {
                Spacer()

                NavigationLink(destination: PreAuthenticationView(), label: {
                    MenuButton(image: Image(systemName: "figure.walk.departure"), name: "Logout")
                }).simultaneousGesture(TapGesture().onEnded {
                    KeychainWrapper.standard.remove(forKey: "bearerToken")
                })

                NavigationLink(destination: EditProfileView(gatherer: self.manager, currentUser: self.currentUser), label: {
                    MenuButton(image: Image(systemName: "gearshape.fill"), name: "Edit")
                })

                Spacer()
            }

            Spacer()
        }
    }
}

struct ManageProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ManageProfileView(manager: DataManager(), currentUser: Personal.init(id: 0, name: "Jan", email: "Jan@Jan.nl", email_verified_at: "", created_at: "", updated_at: "", avatar: ""))
    }
}
