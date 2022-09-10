//
//  SinusData.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import Foundation

// Contains all data required to create a sinus graph.
public struct SinusData {
    // If of the sinus chart
    var id: Int
    
    // List of values for the chart between 0 and 100
    var values: [Int]
    
    // Label containing the date.
    var labels: [String]
    
    // Name of user.
    let sinusName: String
    
    // Name of the target.
    let sinusTarget: String
}
