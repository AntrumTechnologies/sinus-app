//
//  SinusGraph.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import SwiftUI

struct SinusPoint{
    let value: Double
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



struct SinusGraph: View {
    let values = generatePoints().map { Int($0.value) }
    let labels = getLabels()
    
    var body: some View {
        LineChart(values: values, labels: labels)
    }
}

struct SinusGraph_Previews: PreviewProvider {
    static var previews: some View {
        SinusGraph()
    }
}
