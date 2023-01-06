//
//  AutenticationStartView.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/11/2022.
//

import SwiftUI

struct AutenticationStartView: View {
    var body: some View {
        NavigationView {
            VStack {

                Spacer()

                // Login Button
                NavigationLink(destination: LoginView(), label: {
                    MenuButton(image: Image(systemName: "person.fill"), name: "Login")
                })

                // Register Button
                NavigationLink(destination: RegisterView(), label: {
                    MenuButton(image: Image(systemName: "person.fill.badge.plus"), name: "Register")
                })

                Spacer()
            }
        }
    }
}

struct AutenticationStartView_Previews: PreviewProvider {
    static var previews: some View {
        AutenticationStartView()
    }
}
