//
//  GraphListView.swift
//  SinuS
//
//  Created by Loe Hendriks on 05/09/2022.
//

import SwiftUI

// View for a list of rows
struct GraphList: View {
    let charts: [SinusData]
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    List(charts, id: \.id) { c in
                        NavigationLink(
                            destination: LineChart(data: c),
                            label: {
                                Row(data: c)
                            })
                    }.navigationTitle("Sinus Members")
                    
                    VStack(alignment:.trailing) {
                       Spacer()
                       HStack {
                            Spacer()
                            NavigationLink(
                                destination: ProfileView(),
                                label: {
                                    ProfileButton()
                                }).padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 30)
                       }
                    }
                }
            }
        }
    }
}

// Temp helper function
public func generatePoints()  -> [Int] {
    var points = [Int]()
    points.append(0)
    points.append(12)
    points.append(99)
    
    return points
}

// Temp Helper function
public func getLabels() -> [String] {
    var labels = [String]()
    
    for i in 1...3 {
        labels.append(String(i) + "-01")
    }
    
    return labels
}

private func getCharts() -> [SinusData] {
    var list = [SinusData]()
    for i in 1...20 {
        let values = generatePoints()
        let labels = getLabels()
        let l = SinusData(id: i, values: values, labels: labels, sinusName: "Lukas " + String(i), sinusTarget: "Target")
        list.append(l)
    }
    return list
}

struct GraphList_Previews: PreviewProvider {
    static var previews: some View {
        let list = getCharts()
        GraphList(charts: list)
    }
}
