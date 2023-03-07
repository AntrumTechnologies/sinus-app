//
//  Concept1.swift
//  SinuS
//
//  Created by Loe Hendriks on 25/02/2023.
//

import SwiftUI

struct Concept1: View {
    var userData: SinusUserData
    var data: SinusData

    private var pointA: Int {
        if data.values.count > 1 {
            return data.values[data.values.count - 2]
        }
        return 0
    }

    private var pointB: Int {
        if data.values.count > 1 {
            return data.values[data.values.count - 1]
        }
        return 0
    }

    private var percentage: Int {
        return pointB - pointA
    }

    private var color: Color {
        if self.percentage > 0 {
            return .green
        } else if self.percentage < 0 {
            return .red
        }
        return .gray
    }

    private var icon: Image {
        if self.percentage > 0 {
            return Image(systemName: "arrowtriangle.up.fill")
        } else if self.percentage < 0 {
            return Image(systemName: "arrowtriangle.down.fill")
        }
        return Image(systemName: "square.fill")
    }

    private var avatar: Image {
        return Image("Placeholder")
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {

                self.avatar
                    .resizable()
                    .frame(
                        width: 50,
                        height: 50)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Style.SecondAppColor, lineWidth: 4)
                            .shadow(radius: 10)
                    }
                    .padding()
                Text(self.userData.name)
                Image(systemName: "arrow.right")
                    .foregroundColor(Style.AppColor)
                Text(self.userData.date_name)
                Spacer()

//                Spacer()
//                self.icon
//                    .foregroundColor(self.color)
//                Text(String(self.percentage) + "%").foregroundColor(self.color).bold()
//                Spacer()
            }
            .foregroundColor(Style.SecondAppColor)
            WavePreviewView(percentage: self.percentage, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut varius ligula non egestas maximus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus lobortis accumsan tortor, sed scelerisque odio pulvinar ut. Aenean quis ullamcorper ex, at tempor arcu. Aliquam non pellentesque enim. Suspendisse sodales leo in dapibus tincidunt. Aliquam sed leo porttitor, aliquam felis ut, iaculis orci. Suspendisse aliquet, nunc eget malesuada egestas, risus nisl bibendum mauris, ac porta risus ligula vel nibh. Donec volutpat laoreet orci, non finibus metus semper quis.")

        }
    }
}

struct Concept1_Previews: PreviewProvider {
    static var previews: some View {
        Concept1(userData: SinusUserData(
            id: 1,
            name: "Name",
            user_id: 1,
            date_name: "Target",
            created_at: "",
            updated_at: "",
            deleted_at: "",
            archived: 0),
            data: SinusData(
                id: 1,
                values: [ 20, 30],
                labels: [ "label", "Lavel" ],
                sinusName: "Name",
                sinusTarget: "Name"))
    }
}
