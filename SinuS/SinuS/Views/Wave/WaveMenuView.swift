//
//  WaveMenuView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI

struct WaveMenuView: View {
    let gatherer: DataManager
    let user: SinusUserData
    let data: SinusData

    var body: some View {
            HStack {
                Button(action: {
                    self.gatherer.followUser(user_id: self.user.user_id)
                    }
                ) {
                    HStack {
                        Image(systemName: "plus.square")
                        Text("Follow")
                    }
                    .frame(width: 125, height: 30)
                    .foregroundColor(.white)
                    .background(Style.AppColor)
                    .cornerRadius(5)
                    .shadow(radius: 10)
                }

                Button(action: {
                    self.gatherer.unFollowUser(user_id: self.user.user_id)
                    }
                ) {
                    HStack {
                        Image(systemName: "minus.square")
                        Text("Unfollow")
                    }
                    .frame(width: 125, height: 30)
                    .foregroundColor(.white)
                    .background(Style.AppColor)
                    .cornerRadius(5)
                    .shadow(radius: 10)
                }
            }
            .foregroundColor(Style.AppColor)
            .padding()
        }
}

struct WaveMenuView_Previews: PreviewProvider {
    static var previews: some View {
        WaveMenuView(
            gatherer: DataManager(),
            user: SinusUserData(
                id: 1, name: "", user_id: 1, date_name: "",
                created_at: "", updated_at: "", deleted_at: "",
                archived: 0, avatar: "", following: false),
            data: SinusData(
                id: 1, values: [], labels: [], descriptions: [], sinusName: "",
                sinusTarget: ""))
    }
}
