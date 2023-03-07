//
//  PersonalWaveView.swift
//  SinuS
//
//  Created by Loe Hendriks on 07/01/2023.
//

import SwiftUI

struct PersonalWaveView: View {
    let wave: SinusUserData

    var body: some View {
        VStack(alignment: .center) {

            Spacer()
            Image(systemName: "water.waves")
                .resizable()
                .frame(
                    width: 50,
                    height: 50,
                    alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

            Spacer()

            Text("Date:")
                .font(.headline)
            Text(self.wave.date_name)
            Spacer()

        }
        .frame(width: 150, height: 150)
        .foregroundColor(Style.SecondAppColor)
        .background(Style.ThirdAppColor)
        .cornerRadius(5)
        .shadow(radius: 10)
        .foregroundColor(.white)
        .padding(.leading, 15)
    }
}

struct PersonalWaveView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalWaveView(wave: SinusUserData(id: 1, name: "Name", user_id: 2, date_name: "Name", created_at: "", updated_at: "", deleted_at: "", archived: 0))
    }
}
