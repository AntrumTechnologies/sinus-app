//
//  PersonalWaveView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI

struct SingleWaveView: View {
    let wave: SinusUserData

    var body: some View {
        VStack(alignment: .center) {

            Spacer()
            Image("Logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(5)
                .padding()

            Spacer()

            Text(self.wave.date_name)
            Spacer()

        }
        .frame(width: 150, height: 150)
        .foregroundColor(Style.TextOnColoredBackground)
        .background(Style.AppBackground)
        .cornerRadius(5)
        .foregroundColor(.white)
        .padding([.bottom, .top], 3)
        .padding(.leading, 20)
        .padding(.trailing, 10)
    }
}

struct SingleWaveView_Previews: PreviewProvider {
    static var previews: some View {
        SingleWaveView(wave: SinusUserData(id: 1, name: "Name", user_id: 2, date_name: "Name", created_at: "", updated_at: "", deleted_at: "", archived: 0, avatar: "", following: false))
    }
}
