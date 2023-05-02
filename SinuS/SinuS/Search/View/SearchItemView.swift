//
//  SearchItemView.swift
//  SinuS
//
//  Created by Loe Hendriks on 18/04/2023.
//

import SwiftUI

struct SearchItemView: View {
    let user: SinusUserData
    @StateObject var feedItemModel = FeedItemModel(retrievable: ExternalRestRetriever())
    
    var body: some View {
        HStack {
            self.feedItemModel.avatar
                .resizable()
                .frame(
                    width: 80,
                    height: 80)
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(Style.AppColor, lineWidth: 3)
                }
                .padding()
            
            Text(self.user.name)
            Image(systemName: "arrow.right")
                .foregroundColor(Style.AppColor)
            Text(self.user.date_name)
            Spacer()
        }
        .task {
            await self.feedItemModel.reload(userData: user)
        }
    }
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(user: SinusUserData(id: 1, name: "", user_id: 1, date_name: "", created_at: nil, updated_at: nil, deleted_at: nil, archived: nil, avatar: nil, following: nil))
    }
}
