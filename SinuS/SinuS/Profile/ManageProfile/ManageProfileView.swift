//
//  ManageProfileView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 07/01/2023.
//

import SwiftUI
import SwiftKeychainWrapper
import PhotoSelectAndCrop

struct ManageProfileView: View {
    let currentUser: Profile

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

                NavigationLink(destination: ContentView(), label: {
                    MenuButton(image: Image(systemName: "figure.walk.departure"), name: "Logout")
                }).simultaneousGesture(TapGesture().onEnded {
                    KeychainWrapper.standard.remove(forKey: "bearerToken")
                    // TODO: delete token from server as well
                })
                
                Spacer()

                NavigationLink(destination: CropView( user: self.currentUser), label: {
                    MenuButton(image: Image(systemName: "gearshape.fill"), name: "Edit")
                })

                Spacer()
            }

            Spacer()
            
            Text("")
        }
    }
}

struct ManageProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ManageProfileView(currentUser: Profile.init(id: 0, name: "Jan", email: "Jan@Jan.nl", email_verified_at: "", created_at: "", updated_at: "", avatar: ""))
    }
}
