//
//  HeaderWithSubTextView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI
import Kingfisher

struct HeaderView: View {
    var subtext: String
    var avatar: KFImage
    var scaleFactor: Double
    var following: Bool
    var loggedIn: Bool
    let followingModel: FollowingModel
    @State private var user: SinusUserData
    

    
    init(user: SinusUserData, subtext: String, avatar: KFImage, scaleFactor: Double, following: Bool, loggedIn: Bool, followingModel: FollowingModel) {
        self.user = user
        self.subtext = subtext
        self.avatar = avatar
        self.scaleFactor = scaleFactor
        self.following = following
        self.loggedIn = loggedIn
        self.followingModel = followingModel
    }
    
    var body: some View {
        VStack {
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
                    
                    if (self.loggedIn) {
                        Button(action: {
                            Task {
                                await self.followingModel.followingAction(user: self.user)
                            }
                        }
                        ) {
                            HStack {
                                
                                if (self.following) {
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
            .padding([.top, .bottom], 15)
        }
    }
}
