//
//  LineChart2.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/09/2022.
//

import SwiftUI
import Charts

/**
    Internal struct to link values and their labels.
 */
struct ChartPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Int
}

/**
    View showing the user's Sinus/Graph.
 */
struct LineChart2: View {
    private let user: SinusUserData
    private let data: SinusData
    private static var following = false

    init(user: SinusUserData, data: SinusData) {
        self.user = user
        self.data = data
    }

    var points: [ChartPoint] {
        var list = [ChartPoint]()
        for i in 0...self.self.data.values.count - 1 {
            list.append(ChartPoint(label: self.data.labels[i], value: self.data.values[i]))
        }
        return list
    }

    private var color: Color {
        if self.data.values.count > 1 {
            if self.data.values.last! > self.data.values[self.data.values.count - 2] {
                return Color.green
            } else if self.data.values.last! < self.data.values[self.data.values.count - 2] {
                return Color.red
            }
        }
        return Color.gray
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "water.waves")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.bottom)
                Spacer()
            }.background(ContentView.AppColor)
            Divider()

            RelationStatusView(value: self.data.values.last!)

            Divider()
            Chart {
                ForEach(points) { point in
                    LineMark(x: .value("Date", point.label.substring(from: point.label.index(point.label.endIndex, offsetBy: -4))), y: .value("Value", point.value))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 350)
            .shadow(radius: 10)
            .padding()
            .chartPlotStyle { plotArea in
                plotArea
                    .background(ContentView.SecondAppColor)
            }
            .foregroundColor(.white)

            Divider()

            HStack {
                SmallFrame(header: "Name:", text: self.data.sinusName)
                Spacer()

                VStack {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.blue)
                    Divider()
                    Text(String(self.data.values.last!) + " %")
                        .font(.system(size: 10))
                        .foregroundColor(self.color)
                }

                Spacer()
                SmallFrame(header: "Target:", text: self.data.sinusTarget)
            }
            .padding()

            Divider()

            HStack {
                Button("Follow") {
                    var manager = DataManager()
                    manager.FollowUser(user_id: self.user.user_id)
                }
                Spacer()
                Button("Unfollow") {
                    var manager = DataManager()
                    manager.UnFollowUser(user_id: self.user.user_id)
                }

            }
            .foregroundColor(ContentView.AppColor)
            .padding()

        }
    }
}

struct LineChart2_Previews: PreviewProvider {
    static var previews: some View {let values = generatePoints()
        let labels = getLabels()
        LineChart2(user: SinusUserData(id: 1, name: "Lukas", user_id: 1, date_name: "Target", created_at: "", updated_at: "", deleted_at: ""), data: SinusData(id: 1, values: [ 20, 30], labels: [ "label", "Lavel" ], sinusName: "Name", sinusTarget: "Name"))
    }
}
