//
//  HeaderWithSubTextView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI
import Kingfisher

struct HeaderWithSubTextView: View {
    @State private var user: SinusUserData
    var subtext: String
    var avatar: KFImage
    var scaleFactor: Double
    var gatherer: DataManager
    
    @State private var internalFollowing: Bool = false

    init(user: SinusUserData, subtext: String, avatar: KFImage, scaleFactor: Double, gatherer: DataManager) {
        self.user = user
        self.subtext = subtext
        self.avatar = avatar
        self.scaleFactor = scaleFactor
        self.gatherer = gatherer
    }
    
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
                        Text(self.user.name)
                            .font(.system(size: 35 * self.scaleFactor))
                            .foregroundColor(Style.TextOnColoredBackground)

                        Spacer()
                        HStack(spacing: 0) {
                            Text("is dating \(self.subtext)")
                                .foregroundColor(Style.TextOnColoredBackground)
                        }

                        Spacer()
                    }

                    Spacer()
                }

                if (ContentView.LoggedIn) {
                    Button(action: {
                        if (self.user.following ?? true) {
                            print("Unfollow")
                            self.gatherer.unFollowUser(user_id: self.user.user_id)
                        }
                        else{
                            print("Follow")
                            self.gatherer.followUser(user_id: self.user.user_id)
                        }
                        
                        self.gatherer.getSingleUser(user_id: self.user.user_id)
                    }
                    ) {
                        HStack {
                            if (self.user.following ?? true) {
                                Text("Unfollow")
                            }
                            else{
                                Text("Follow")
                            }
                        }
                        .frame(width: 100, height: 30)
                        .foregroundColor(.white)
                        .background(Style.AppColor)
                        .cornerRadius(5)
                        .padding(.leading, 5)
                    }
                }
                Spacer()
            }

            Spacer()
        }
        .frame(width: 350, height: 150)
        .background(Style.AppBackground)
        .cornerRadius(5)
        .shadow(radius: 10)
        .padding([.top, .bottom], 15)
    }
}
