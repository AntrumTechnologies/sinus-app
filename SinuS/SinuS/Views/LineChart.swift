//
//  LineChart.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI

struct LineChart: View {
    
    let values: [Int]
    let labels: [String]
    
    let screenWidth = UIScreen.main.bounds.width
    
    private var path: Path {
        if self.values.isEmpty {
            return Path()
        }
        
        var xOffset: Int = Int(screenWidth/CGFloat(self.values.count))
        var path = Path()
        path.move(to: CGPoint(x: xOffset, y: self.values[0]))
        
        for value in self.values {
            xOffset += Int(screenWidth/CGFloat(self.values.count))
            path.addLine(to: CGPoint(x: xOffset, y: value))
        }
        
        return path
    }
    
    var body: some View {
        VStack {
            Text("Line chart test")
            self.path.stroke(Color.black, lineWidth: 2.0)
        }
    }
}

// Temp helper function
private func generatePoints()  -> [SinusPoint] {
    var points = [SinusPoint]()
    
    for _ in 1...20 {
        let p = SinusPoint(value: Double.random(in: 0...100))
        points.append(p)
    }
    
    return points
}

// Temp Helper function
private func getLabels() -> [String] {
    var labels = [String]()
    
    for i in 1...20 {
        labels.append(String(i))
    }
    
    return labels
}


struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        let values = generatePoints().map { Int($0.value) }
        let labels = getLabels()
        LineChart(values: values, labels: labels)
    }
}
