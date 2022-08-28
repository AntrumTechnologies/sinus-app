//
//  SinusData.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import Foundation

struct SinusData {
    // Name of the sinus graph
    var name: String
    
    // List of points to display
    private var points: [Int]
    
    // Adds a point to the list
    public mutating func addPoint(point: Int) {
        self.points.append(point)
    }
}
