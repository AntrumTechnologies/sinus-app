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
        
        var xOffset: Int = Int(screenWidth/CGFloat(self.data.values.count))
        var path = Path()
        path.move(to: CGPoint(x: xOffset, y: self.data.values[0]))
        
        for value in self.data.values {
            xOffset += Int(screenWidth/CGFloat(self.data.values.count))
            path.addLine(to: CGPoint(x: xOffset, y: value))
        }
        
        return path
    }
    
    var body: some View {
        ZStack {
            Color.black
            ZStack {
                Color.gray
                VStack {
                    Text(data.sinusName)
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.top, 50)
                    
                    self.path.stroke(Color.white, lineWidth: 2.0).padding(.top, 100)
                        .rotationEffect(.degrees(180), anchor: .center)
                        .rotation3DEffect(
                            .degrees(180),
                            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                
                    HStack {
                        ForEach(self.data.labels, id: \.self) { label in
                            Text(label)
                                .frame(width: screenWidth/CGFloat(self.data
                                    .labels.count) - 10)
                                .font(.system(size: 12))
                                .foregroundColor(.white)
                        }
                    }
                }
                .ignoresSafeArea()
            }
            .frame(maxWidth: .infinity, maxHeight: 350)
        }
        .ignoresSafeArea()
    }
    
}


struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        let values = generatePoints()
        let labels = getLabels()
        LineChart(data: SinusData(id: 1, values: values, labels: labels, sinusName: "Lukas"))
    }
}
