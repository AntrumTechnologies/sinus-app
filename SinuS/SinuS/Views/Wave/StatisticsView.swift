//
//  StatisticsView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI

struct StatisticsView: View {
    let data: SinusData

    private var max: Int {
        if data.values.count < 1 {
            return 0
        }

        return self.data.values.max()!
    }

    private var min: Int {
        if data.values.count < 1 {
            return 0
        }

        return self.data.values.min()!
    }

    private var currentScore: Int {
        if data.values.count < 1 {
            return 0
        }

        return self.data.values.last!
    }

    private var startDate: String {
        if data.values.count < 1 {
            return ""
        }

        return self.data.labels.first!
    }

    private var duration: Int {
        if data.values.count < 2 {
            return 0
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let initialDate = dateFormatter.date(from: data.labels.first!)
        let lastDate = dateFormatter.date(from: data.labels.last!)

        return Calendar.current.dateComponents([.day], from: initialDate!, to: lastDate!).day!
    }

    var body: some View {

        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chart.bar.xaxis")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Statistics:")
                    .font(.headline)
                    .padding(.top, 5)
            }
            .foregroundColor(Style.SecondAppColor)

            VStack(alignment: .center) {

                Divider()

                HStack {
                    Text("Current Score:")
                        .padding(.leading, 20)
                    Spacer()
                    Text("\(self.currentScore) %")
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 15)
                .padding(.top, 15)
                Divider()

                HStack {
                    Text("Duration:")
                        .padding(.leading, 20)
                    Spacer()
                    Text("\(self.duration) days")
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 15)
                .padding(.top, 15)

                Divider()

                HStack {
                    Text("Max value:")
                        .padding(.leading, 20)
                    Spacer()
                    Text("\(self.max)")
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 15)
                .padding(.top, 15)

                Divider()

                HStack {
                    Text("Min value:")
                        .padding(.leading, 20)
                    Spacer()
                    Text("\(self.min)")
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 15)
                .padding(.top, 15)

                Divider()

                HStack {
                    Text("Start date:")
                        .padding(.leading, 20)
                    Spacer()
                    Text(self.startDate)
                        .padding(.trailing, 20)
                }
                .padding(.bottom, 15)
                .padding(.top, 15)

            }
            .frame(width: 350)
            .foregroundColor(Style.SecondAppColor)

            .background(Style.ThirdAppColor)
            .cornerRadius(5)
            .shadow(radius: 10)
            .foregroundColor(.white)
            .padding()
        }

    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(data: SinusData(id: 1, values: [], labels: [], sinusName: "", sinusTarget: ""))
    }
}
