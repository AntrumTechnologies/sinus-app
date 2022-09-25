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

// Net concept line chart view
struct LineChart2: View {
    let data: SinusData
    
    var points: [ChartPoint] {
        var list = [ChartPoint]()
        for i in 0...self.data.values.count - 1 {
            list.append(ChartPoint(label: data.labels[i], value: data.values[i]))
        }
        return list;
    }
    
    private var color: Color {
        if (data.values.count > 1) {
            if (data.values.last! > data.values[data.values.count - 2]) {
                return Color.green
            }
            else if (data.values.last! < data.values[data.values.count - 2]) {
                return Color.red
            }
        }
        return Color.gray
    }
    
    var body: some View {
        VStack {
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
                    .background(.red.opacity(0.5))
            }
            .foregroundColor(.white)
            
            Divider()
            
            HStack{
                SmallFrame(header: "Name:", text: data.sinusName)
                Spacer()
                
                VStack {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.blue)
                    Divider()
                    Text(String(data.values.last!) + " %")
                        .font(.system(size: 10))
                        .foregroundColor(self.color)
                }
                
                Spacer()
                SmallFrame(header: "Target:", text: data.sinusTarget)
            }
            .padding()
            Divider()
        }
    }
}

struct LineChart2_Previews: PreviewProvider {
    static var previews: some View {let values = generatePoints()
        let labels = getLabels()
        LineChart2(data: SinusData(id: 1, values: values, labels: labels, sinusName: "Lukas", sinusTarget: "Target"))
    }
}
