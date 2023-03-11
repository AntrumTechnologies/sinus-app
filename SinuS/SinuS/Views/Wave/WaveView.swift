//
//  LineChart2.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/09/2022.
//

import SwiftUI
import Charts

struct ChartPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Int
}

struct WaveView: View {
    private let gatherer: DataManager
    private let user: SinusUserData
    private let data: SinusData
    private static var following = false

    init(gatherer: DataManager, user: SinusUserData, data: SinusData) {
        self.gatherer = gatherer
        self.user = user
        self.data = data
    }

    var points: [ChartPoint] {
        var list = [ChartPoint]()
        print(self.data.values.count)
        if self.data.values.count > 1 {
            for val in 0...self.self.data.values.count - 1 {
                list.append(ChartPoint(label: self.data.labels[val], value: self.data.values[val]))
            }

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
            HeaderWithSubTextView(
                user: self.user,
                subtext: self.data.sinusTarget,
                avatar: Image("Placeholder"),
                scaleFactor: 1,
                gatherer: self.gatherer)

            ScrollView(.vertical) {
                Divider()

                ChartView(points: self.points)
                    .frame(height: 450)

                CompareButtonView(gatherer: self.gatherer, data: self.data)
                    .padding(.bottom)

                Divider()

                StatisticsView(data: self.data)
                
                Divider()
                
                HistoryView(descriptions: self.data.descriptions, dates: self.data.labels)
                

            }
        }
        .toolbar(.visible, for: ToolbarPlacement.navigationBar)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct LineChart2_Previews: PreviewProvider {
    static var previews: some View {
        WaveView(
            gatherer: DataManager(),
            user: SinusUserData(
            id: 1,
            name: "Lukas",
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
                labels: [ "label", "Lavel" ],descriptions: [],
                sinusName: "Name",
                sinusTarget: "Name"))
    }
}
