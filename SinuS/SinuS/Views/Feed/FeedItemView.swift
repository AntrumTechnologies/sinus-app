//
//  Concept1.swift
//  SinuS
//
//  Created by Loe Hendriks on 25/02/2023.
//

import SwiftUI

struct FeedItemView: View {
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
                        Circle().stroke(Style.TextOnColoredBackground, lineWidth: 4)
                            .shadow(radius: 10)
                    }
                    .padding()
                
                Text(self.userData.name)
                Image(systemName: "arrow.right")
                    .foregroundColor(Style.AppColor)
                Text(self.userData.date_name)
                Spacer()
            }
            .foregroundColor(Style.TextOnColoredBackground)
            WavePreviewView(percentage: self.percentage, description: self.data.descriptions.last!)

        }
    }
}

struct FeedItemView_Previews: PreviewProvider {
    static var previews: some View {
        FeedItemView(userData: SinusUserData(
            id: 1,
            name: "Name",
            user_id: 1,
            date_name: "Target",
            created_at: "",
            updated_at: "",
            deleted_at: "",
            archived: 0,
            avatar: "",
            following: false),
            data: SinusData(
                id: 1,
                values: [ 20, 30],
                labels: [ "label", "Lavel" ],
                descriptions: [],
                sinusName: "Name",
                sinusTarget: "Name"))
    }
}
