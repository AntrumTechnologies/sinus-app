//
//  CreatedWavesView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI

struct CreatedWavesView: View {
    let waves: [SinusUserData]
    
    init(waves: [SinusUserData]) {
        self.waves = waves
    }

    var body: some View {
        if (waves.count != 0) {
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
                            NavigationLink(
                                destination: WaveView(user: wave),
                                label: {
                                    SingleWaveView(wave: wave)
                                })
                        }
                    }
                    
                }
                .frame(height: 185)
            }
            
            Divider()
        }
    }
}

struct CreatedWavesView_Previews: PreviewProvider {
    static var previews: some View {
        let waves = [
            SinusUserData(id: 1, name: "Name", user_id: 2, date_name: "Target1", created_at: "", updated_at: "", deleted_at: "", archived: 0, avatar: "", following: false),
        ]

        CreatedWavesView(waves: waves)
    }
}
