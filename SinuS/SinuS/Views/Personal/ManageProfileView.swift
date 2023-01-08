//
//  ManageProfileView.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 07/01/2023.
//

import SwiftUI

struct ManageProfileView: View {
    let manager: DataManager

    var body: some View {
        VStack {
            Spacer()

            NavigationLink(destination: AuthenticationStartView(), label: {
                MenuButton(image: Image(systemName: "figure.walk.departure"), name: "Logout")
            })

            Spacer()
        }
    }
}

struct ManageProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ManageProfileView(manager: DataManager())
    }
}
