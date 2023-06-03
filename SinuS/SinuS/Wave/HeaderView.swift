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
    var followingModel: FollowingModel
    @State private var user: SinusUserData
    
    private var followingBackGround : Color {
        if (self.following) {
            return .white
        }
        else {
            return Style.AppColor
        }
    }
    
    private var followingForeGround : Color {
        if (self.following) {
            return Style.AppColor
        }
        else {
            return .white
        }
        
    }
    
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
                    
                    HStack{
                        HStack{
                            Image(systemName: "person.2.fill")
                            Text("\(self.user.followers ?? 0)")
                        }
                        .frame(width: 100, height: 30)
                        .foregroundColor(Style.TextOnColoredBackground)
                        .cornerRadius(5)
                        .padding(.leading, 5)
                        
                        Spacer()
                        
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
                                .foregroundColor(self.followingForeGround)
                                .background(self.followingBackGround)
                                .cornerRadius(5)
                            }
                        }
                    }
                    .padding(.bottom, 5)
                    
                    
                }
                
                Spacer()
                
            }
            .frame(width: 350, height: 160)
            .background(Style.AppBackground)
            .cornerRadius(5)
            .padding([.top, .bottom], 15)
        }
    }
}
