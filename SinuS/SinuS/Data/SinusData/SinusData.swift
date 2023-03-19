//
//  SinusData.swift
//  SinuS
//
//  Created by Loe Hendriks on 28/08/2022.
//

import Foundation

/**
    Class holding all data required to create a sinus graph.
 */
public class SinusData: ObservableObject, Identifiable, Codable {
    init(id: Int, values: [Int], labels: [String], descriptions: [String], sinusName: String, sinusTarget: String) {
        self.id = id
        self.values = values
        self.labels = labels
        self.descriptions = descriptions
        self.sinusName = sinusName
        self.sinusTarget = sinusTarget
    }

    /**
        Id of the sinus chart
     */
    public var id: Int

    /**
        List of values for the chart between 0 and 100
     */
    public var values: [Int]

    /**
        Label containing the date.
     */
    public var labels: [String]

    public var descriptions: [String]
    
    /**
        Label containing the date.
     */
    public let sinusName: String

    /**
        Name of the target.
     */
    public let sinusTarget: String
}
