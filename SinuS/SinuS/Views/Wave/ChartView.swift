//
//  ChartView.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/01/2023.
//

import SwiftUI
import Charts

struct ChartView: View {
    let points: [ChartPoint]

    private var charWidth: CGFloat {
        let width = CGFloat(points.count) * 100

        if width <= (UIScreen.main.bounds.size.width - 30) {
            return UIScreen.main.bounds.size.width - 30
        }

        return width
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "chart.xyaxis.line")
                    .padding(.leading, 15)
                    .padding(.top, 5)
                Text("Chart")
                    .font(.headline)
                    .padding(.top, 5)
            }
            .foregroundColor(Style.AppColor)

            ScrollView(.horizontal) {
                Chart {
                    ForEach(points) { point in
                        if point.value != 0 {
                            LineMark(x: .value("Date", point.label), y: .value("Value", point.value))
                                .foregroundStyle(Style.TextOnColoredBackground)
                                .symbol() {
                                    Circle()
                                        .fill(Style.TextOnColoredBackground)
                                        .frame(width: 20)
                                        .overlay(
                                            Text("\(point.value)")
                                                .font(.system(size: 10))
                                                .foregroundColor(.white))
                                }
                        }
                    }
                }.chartYScale(domain: 0...100)
                .frame(width: self.charWidth, height: 200)
                .shadow(radius: 10)
                .padding()
                .chartPlotStyle { plotArea in
                    plotArea
                        .background(Style.AppBackground)
                }
                .foregroundColor(Style.TextOnColoredBackground)
                .flipsForRightToLeftLayoutDirection(true)            }

        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(points: [])
    }
}
