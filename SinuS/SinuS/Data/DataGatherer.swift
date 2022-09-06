//
//  DataGatherer.swift
//  SinuS
//
//  Created by Loe Hendriks on 06/09/2022.
//

import Foundation

// TODO(LoeHen) This class should do the REST class to retrieve data.
public class DataGatherer {
    
    public static func CollectData() -> [SinusData] {
        var data = [SinusData]()
        
        data.append(CollectSingleSinusData(name: "Lukas", id: 1))
        data.append(CollectSingleSinusData(name: "Stef", id: 2))
        data.append(CollectSingleSinusData(name: "Jose", id: 3))
        data.append(CollectSingleSinusData(name: "Wim", id: 4))
        
        return data
    }
    
    private static func CollectSingleSinusData(name: String, id: Int) -> SinusData {
        // Replace data generation by REST get calls.
        let labels = getLabels()
        let values = generatePoints()
        
        return SinusData(id: id, values: values, labels: labels, sinusName: name)
    }
}
