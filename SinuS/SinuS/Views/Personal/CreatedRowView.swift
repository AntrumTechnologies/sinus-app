//
//  CreatedRowView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI

struct CreatedRowView: View {
    let gatherer: DataManager
    let waves: [SinusUserData]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "water.waves")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Your waves")
                    .font(.headline)
                    .padding(.top, 5)
            }.foregroundColor(Style.AppColor)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(waves, id: \.id) { wave in
                        let data = gatherer.gatherSingleData(user: wave)
                        NavigationLink(
                            destination: WaveView(gatherer: self.gatherer, user: wave, data: data),
                            label: {
                                PersonalWaveView(wave: wave)
                            })
                    }
                }

            }
            .frame(height: 185)
        }
    }
}

struct CreatedRowView_Previews: PreviewProvider {
    static var previews: some View {
        let waves = [
            SinusUserData(id: 1, name: "Name", user_id: 2, date_name: "Target1", created_at: "", updated_at: "", deleted_at: "", archived: 0, avatar: "", following: false),
        ]

        CreatedRowView(gatherer: DataManager(), waves: waves)
    }
}
