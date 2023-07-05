//
//  ProfileButton.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import SwiftUI

struct ProfileButton: View {
    var body: some View {
            Image(systemName: "person")
            .frame(width: 50, height: 50)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))

    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton()
    }
}
