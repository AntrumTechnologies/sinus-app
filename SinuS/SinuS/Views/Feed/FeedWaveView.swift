//
//  Row.swift
//  SinuS
//
//  Created by Loe Hendriks on 05/09/2022.
//

import SwiftUI

/**
    View for the rows in the list of users. Can be expanded with user picture.
 */
struct FeedWaveView: View {
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

    /**
        The view.
     */
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Image(systemName: "person.fill")
                Text(self.userData.name)
                Image(systemName: "arrow.right")
                Text(self.userData.date_name)
                Spacer()

                Spacer()
                self.icon
                    .foregroundColor(self.color)
                Text(String(self.percentage) + "%").foregroundColor(self.color).bold()
                Spacer()
            }.foregroundColor(Style.AppColor)

            Spacer()
            FeedWaveGraphView(pointA: self.pointA, pointB: self.pointB)
                .shadow(radius: 10)
            Spacer()
        }
        .frame(height: 260)
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        FeedWaveView(userData: SinusUserData(
            id: 1,
            name: "Name",
            user_id: 1,
            date_name: "Target",
            created_at: "",
            updated_at: "",
            deleted_at: "",
            archived: 0,
            following: false),
            data: SinusData(
                id: 1,
                values: [ 20, 30],
                labels: [ "label", "Lavel" ],
                descriptions: [ "label", "Lavel" ],
                sinusName: "Name",
                sinusTarget: "Name"))
    }
}
