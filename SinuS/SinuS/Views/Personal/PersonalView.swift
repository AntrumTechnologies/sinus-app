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
        return self.gatherer.getCurrentUser()
    }

    var currentAvatar: KFImage {
        let avatar: String = currentUser!.avatar ?? "avatars/placeholder.jpg"
        let url: URL = URL(string: "https://lovewaves.antrum-technologies.nl/" + avatar)!
        return KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }
    
    @State private var internalWaves : [SinusUserData] = []
    var waves: [SinusUserData] {
        if (self.internalWaves.count == 0)
        {
            self.internalWaves = gatherer.gatherUsers(postfix: "/created")
        }
        
        return self.internalWaves
    }
    
    var body: some View {
        
        
        
        
        VStack {
            ScrollView(.vertical) {
                ProfileHeaderView(
                    name: self.currentUser!.name,
                    avatar: self.currentAvatar,
                    scaleFactor: 1)

                Divider()

                CreatedRowView(gatherer: gatherer, waves: self.waves)

                Divider()

                UpdateWaveView(manager: gatherer, waves: self.waves)

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
