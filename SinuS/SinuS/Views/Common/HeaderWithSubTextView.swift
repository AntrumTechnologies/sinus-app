//
//  HeaderWithSubTextView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI

struct HeaderWithSubTextView: View {
    let name: String
    let subtext: String
    let avatar: Image
    let scaleFactor: Double

    var body: some View {
        HStack {
            self.avatar
                .resizable()
                .frame(
                    width: 100 * self.scaleFactor,
                    height: 100 * self.scaleFactor)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                        .shadow(radius: 10)
                }
                .padding()

            Spacer()

            VStack {
                Text(self.name)
                    .font(.system(size: 35 * self.scaleFactor))
                    .foregroundColor(.white)
                Text(self.subtext)
                    .foregroundColor(.white)
                    .padding(.top, 1)
            }

            Spacer()

        }
        .frame(width: 350, height: 100)
        .background(Style.ThirdAppColor)
        .cornerRadius(5)
        .shadow(radius: 10)
        .padding(.top, 15)
    }
}

struct HeaderWithSubTextView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderWithSubTextView(name: "Test",
                              subtext: "is dateing someone",
                              avatar: Image("Placeholder"),
                              scaleFactor: 1)
    }
}
