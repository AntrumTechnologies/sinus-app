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
                /*Chart {
                    var i: Int = 0
                    ForEach(points) { point in
                        if i == 0 {
                            LineMark(x: .value("Date", point.label.substring(from: point.label.index(point.label.endIndex, offsetBy: -5))), y: .value("Value", point.value))
                                .foregroundStyle(Style.TextOnColoredBackground)
                            i = 1
                        }
                    }
                }
                .frame(width: self.charWidth)
                // .frame(maxWidth: .infinity, maxHeight: 600)
                .shadow(radius: 10)
                .padding()
                .chartPlotStyle { plotArea in
                    plotArea
                        .background(Style.AppBackground)
                }
                .foregroundColor(Style.TextOnColoredBackground)
                .flipsForRightToLeftLayoutDirection(true)*/
            }

        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(points: [])
    }
}
