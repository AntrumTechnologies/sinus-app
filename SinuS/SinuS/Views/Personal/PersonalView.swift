//
//  PersonalView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI

struct PersonalView: View {
    let gatherer: DataManager

    var name: String {
        let currentUser = self.gatherer.getCurrentUser()

        if currentUser == nil {
            return "Unknown"
        }

        return currentUser!.success.name
    }

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ProfileHeaderView(
                    name: self.name,
                    avatar: Image("Placeholder"),
                    scaleFactor: 1)

                Divider()

                CreatedRowView(gatherer: gatherer, waves: gatherer.gatherUsers(postfix: "/created"))

                Divider()

                ProfileView(manager: gatherer, waves: gatherer.gatherUsers(postfix: "/created"))

                Divider()

                NewWaveView(manager: gatherer)

                Divider()

                ManageProfileView(manager: gatherer)
            }

        }
    }
}

struct PersonalView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalView(gatherer: DataManager())
    }
}
