//
//  CompareView.swift
//  SinuS
//
//  Created by Loe Hendriks on 08/01/2023.
//

import SwiftUI
import Charts

struct CompareView: View {
    let originData: SinusData
    let compareName: String
    let merged: Bool

    @ObservedObject var compareModel = CompareModel()
    
    private func charWidth(points: [ChartPoint]) -> CGFloat {
        let width = CGFloat(points.count) * 100

        if width <= (UIScreen.main.bounds.size.width - 30) {
            return UIScreen.main.bounds.size.width - 30
        }
        print(width)
        return width
    }
    
    private var longestList: [ChartPoint] {
        if (self.compareModel.originPoints.count >= self.compareModel.comparePoints.count) {
            return self.compareModel.originPoints
        }
        
        return self.compareModel.comparePoints
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack (alignment: .leading) {
                HStack {
                    Image(systemName: "chart.xyaxis.line")
                        .padding(.leading, 15)
                        .padding(.top, 5)
                    Text("Chart(s)")
                        .font(.headline)
                        .padding(.top, 5)
                }
                .foregroundColor(Style.AppColor)
                .padding(.top)
                
                ScrollView(.horizontal) {
                    Chart {
                        ForEach(compareModel.comparePoints) { point in
                           LineMark(x: .value("Point", point.label), y: .value("Value", point.value),
                                    series: .value("Serie", "A"))
                               .foregroundStyle(.white)
                                .symbol() {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 20)
                                        .overlay(
                                            Text("\(point.value)")
                                                .font(.system(size: 10))
                                                .foregroundColor(Style.TextOnColoredBackground))
                                }
                       }
                        
                        if (merged) {
                            ForEach(compareModel.originPoints) { point in
                               LineMark(x: .value("Point", point.label), y: .value("Value", point.value), series: .value("Serie", "B"))
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
                        .frame(width: self.charWidth(points: self.merged ? self.longestList: self.compareModel.comparePoints), height: 250)
                    .shadow(radius: 10)
                    .padding()
                    .chartPlotStyle { plotArea in
                        plotArea
                            .background(Style.AppBackground)
                    }
                    .foregroundColor(Style.TextOnColoredBackground)
                    .flipsForRightToLeftLayoutDirection(true)
                }
                    
                
                if (!merged) {
                    ScrollView(.horizontal) {
                        Chart {
                            ForEach(compareModel.originPoints) { point in
                               LineMark(x: .value("Point", point.label), y: .value("Value", point.value), series: .value("Serie", "B"))
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
                            
                        }.chartYScale(domain: 0...100)
                            .frame(width: self.charWidth(points: self.compareModel.originPoints), height: 250)
                            .shadow(radius: 10)
                            .padding()
                            .chartPlotStyle { plotArea in
                                plotArea
                                    .background(Style.AppBackground)
                            }
                            .foregroundColor(Style.TextOnColoredBackground)
                            .flipsForRightToLeftLayoutDirection(true)
                    }
                }
                
                LegendView(whiteName: self.compareName, darkName: "\(self.originData.sinusName) - \(self.originData.sinusTarget)")
            }
        }
        .task{
            await self.compareModel.reload(originData: self.originData, compareName: self.compareName)
        }
        .refreshable{
            await self.compareModel.reload(originData: self.originData, compareName: self.compareName)
        }
        .toolbar(.visible, for: ToolbarPlacement.navigationBar)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct CompareView_Previews: PreviewProvider {
    static var previews: some View {

        CompareView(originData: SinusData(id: 1, values: [], labels: [], descriptions: [], sinusName: "", sinusTarget: ""), compareName: "", merged: true)
    }
}
