//
//  LineChart.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI

// The chart view, contains the name of the user
// and a line graph with data and labels.
struct LineChart: View {
    let data: SinusData
    let screenWidth = UIScreen.main.bounds.width

    private var path: Path {
        if self.data.values.isEmpty {
            return Path()
        }

        var path = Path()
        path.move(to: CGPoint(x: 10, y: 0))
        path.addLine(to: CGPoint(x: Int(screenWidth - 20), y: 20))

        return path
    }

    var body: some View {
        VStack {
            ZStack {
                Color.yellow
                VStack {
                    self.path.stroke(Color.blue, lineWidth: 2.0).padding(.top, 100)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(
                            .degrees(180),
                            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, maxHeight: 300)

                    HStack {
                        ForEach(self.data.labels, id: \.self) { label in
                            Text(label.substring(from: label.index(label.endIndex, offsetBy: -4)))
                                .frame(width: screenWidth/CGFloat(self.data
                                    .labels.count)-10, height: 20)
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                        }
                    }
                }
                .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: 350)
            .cornerRadius(15)
            .shadow(radius: 10)
            .padding()

            HStack {
                SmallFrame(header: "Name:", text: data.sinusName)
                Spacer()
                SmallFrame(header: "Target:", text: data.sinusTarget)
            }
            .padding()
        }
        .ignoresSafeArea()
    }

}

struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        let values = generatePoints()
        let labels = getLabels()
        LineChart(data: SinusData(id: 1, values: values, labels: labels, sinusName: "Lukas", sinusTarget: "Target"))
    }
}
