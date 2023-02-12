//
//  PersonalView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI
import Kingfisher

struct PersonalView: View {
    let gatherer: DataManager

    var currentUser: UserData? {
        return self.gatherer.getCurrentUser()?.success
    }

    var currentAvatar: KFImage {
        let avatar: String = currentUser!.avatar ?? "avatars/placeholder.jpg"
        let url: URL = URL(string: "https://lovewaves.antrum-technologies.nl/" + avatar)!
        return KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ProfileHeaderView(
                    name: self.currentUser!.name,
                    avatar: self.currentAvatar,
                    scaleFactor: 1)

                Divider()

                CreatedRowView(gatherer: gatherer, waves: gatherer.gatherUsers(postfix: "/created"))

                Divider()

                ProfileView(manager: gatherer, waves: gatherer.gatherUsers(postfix: "/created"))

                Divider()

                NewWaveView(manager: gatherer)

                Divider()

                ManageProfileView(manager: gatherer, currentUser: self.currentUser!)
            }

        }
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView(gatherer: DataManager())
    }
}
