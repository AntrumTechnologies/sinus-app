//
//  CompareView.swift
//  SinuS
//
//  Created by Loe Hendriks on 08/01/2023.
//

import SwiftUI
import Charts

struct CompareView: View {
    let initialData: SinusData
    let gatherer: DataManager
    @State private var selection = ""

    var options: [String] {
        let users = gatherer.gatherUsers()

        return users.map { "\($0.name) - \($0.date_name)" }
    }

    var points: [ChartPoint] {
        var list = [ChartPoint]()
        if self.initialData.values.count > 1 {
            for val in 0...self.self.initialData.values.count - 1 {
                list.append(ChartPoint(label: self.initialData.labels[val], value: self.initialData.values[val]))
            }

        }

        return list
    }

    @State private var comparePoints: [ChartPoint] = []

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: "water.waves")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.white)
                    .padding(.bottom)
                Text("Compare")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .padding(.bottom)
                Spacer()
            }
            .background(Style.AppColor)

            Spacer()

            Chart {
                ForEach(points) { point in
                    LineMark(x: .value("Date", point.label.substring(from: point.label.index(point.label.endIndex, offsetBy: -4))), y: .value("Value", point.value),
                             series: .value("Serie", "A"))
                        .foregroundStyle(.white)
                }

                ForEach(comparePoints) { point in
                    LineMark(x: .value("Date", point.label.substring(from: point.label.index(point.label.endIndex, offsetBy: -4))), y: .value("Value", point.value), series: .value("Serie", "B"))
                        .foregroundStyle(.black)
                }

            }
            .frame(maxWidth: .infinity, maxHeight: 350)
            .shadow(radius: 10)
            .padding()
            .chartPlotStyle { plotArea in
                plotArea
                    .background(Style.SecondAppColor)
            }
            .foregroundColor(.white)

            Spacer()

            HStack {
                Spacer()

                Picker("Select a paint color", selection: $selection) {
                    ForEach(options, id: \.self) {
                        Text($0)
                    }
                }
                .frame(height: 40)
                .background(Style.ThirdAppColor)
                .cornerRadius(5)
                .shadow(radius: 10)

                Spacer()

                Button("Compare") {
                    let nameAndTarget = selection.components(separatedBy: " - ")
                    let name = nameAndTarget[0]
                    let target = nameAndTarget[1]

                    let user = self.gatherer.gatherUsers().filter { userOption in
                        return (userOption.name == name && userOption.date_name == target)
                    }.first

                    if user != nil {
                        let data = gatherer.gatherSingleData(user: user!)

                        var list = [ChartPoint]()

                        if data.values.count > 1 {
                            for val in 0...data.values.count - 1 {
                                list.append(ChartPoint(label: data.labels[val], value: data.values[val]))
                            }

                        }

                        comparePoints = list

                    }
                }
                .frame(width: 100, height: 40)
                .background(Style.ThirdAppColor)
                .cornerRadius(5)
                .shadow(radius: 10)

                Spacer()
            }

            Spacer()
        }
    }
}

struct CompareView_Previews: PreviewProvider {
    static var previews: some View {

        CompareView(initialData: SinusData(
            id: 1,
            values: [ 20, 30],
            labels: [ "label", "Lavel" ],
            sinusName: "Name",
            sinusTarget: "Name"),
                    gatherer: DataManager())
    }
}
