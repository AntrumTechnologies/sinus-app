//
//  ProfileHeaderView.swift
//  SinuS
//
//  Created by Loe Hendriks on 08/01/2023.
//

import SwiftUI
import Kingfisher

struct ProfileHeaderView: View {
    let name: String
    let avatar: KFImage
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
                    Circle().stroke(Style.AppColor, lineWidth: 4)
                        .shadow(radius: 10)
                }

            Spacer()

            Text(self.name)
                .font(.system(size: 35 * self.scaleFactor))
                .foregroundColor(Style.AppColor)

            Spacer()

        }.padding(15)
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(
            name: "Test",
            avatar: KFImage(URL(string: "https://example.com")),
            scaleFactor: 1)
    }
}
