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
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    self.avatar
                        .resizable()
                        .frame(
                            width: 80 * self.scaleFactor,
                            height: 80 * self.scaleFactor)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(Style.TextOnColoredBackground, lineWidth: 4)
                                .shadow(radius: 10)
                        }
                        .padding()

                    Spacer()
                    VStack {
                        Spacer()
                        Text(self.name)
                            .font(.system(size: 35 * self.scaleFactor))
                            .foregroundColor(Style.TextOnColoredBackground)

                        Spacer()
                        HStack(spacing: 0) {
                            Text("Is dating")
                                .foregroundColor(Style.TextOnColoredBackground)

                            self.avatar
                                .resizable()
                                .frame(
                                    width: 40 * self.scaleFactor,
                                    height: 40 * self.scaleFactor)
                                .clipShape(Circle())
                                .overlay {
                                    Circle().stroke(Style.TextOnColoredBackground, lineWidth: 4)
                                        .shadow(radius: 10)
                                }
                                .padding()

                            Text(self.subtext)
                                .foregroundColor(Style.TextOnColoredBackground)
                        }

                        Spacer()
                    }

                    Spacer()
                }

                Button(action: {
                    // self.gatherer.followUser(user_id: self.user.user_id)
                }
                ) {
                    HStack {
                        Text("Follow")
                    }
                    .frame(width: 100, height: 30)
                    .foregroundColor(.white)
                    .background(Style.AppColor)
                    .cornerRadius(5)
                    .padding(.leading, 5)
                }

                Spacer()
            }

            Spacer()
        }
        .frame(width: 350, height: 180)
        .background(Style.AppBackground)
        .cornerRadius(5)
        .shadow(radius: 10)
        .padding([.top, .bottom], 15)
    }
}

struct HeaderWithSubTextView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderWithSubTextView(name: "Test",
                              subtext: "Someone",
                              avatar: Image("Placeholder"),
                              scaleFactor: 1)
    }
}
