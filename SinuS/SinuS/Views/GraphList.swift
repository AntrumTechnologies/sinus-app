//
//  GraphListView.swift
//  SinuS
//
//  Created by Loe Hendriks on 05/09/2022.
//

import SwiftUI

/**
    View for a list of rows.
 */
struct GraphList: View {
    let gatherer: DataManager
    let onlyFollowing: Bool

    var body: some View {
        ZStack {
            ZStack {
                List(gatherer.gatherUsers(onlyFollowing: self.onlyFollowing).sorted {
                    $0.name < $1.name
                }, id: \.id) { user in
                    let data = gatherer.gatherSingleData(user: user)

                    NavigationLink(
                        destination: LineChart2(user: user, data: data),
                        label: {
                            FeedWaveView(userData: user, data: data)
                        })
                }
            }
        }
    }
}

/**
    Temp helper function.
 */
public func generatePoints() -> [Int] {
    var points = [Int]()
    points.append(0)
    points.append(12)
    points.append(99)

    return points
}

/**
    Temp helper function.
 */
public func getLabels() -> [String] {
    var labels = [String]()

    for val in 1...3 {
        labels.append(String(val) + "-01")
    }

    return labels
}

/**
    Temp helper function.
 */
private func getCharts() -> [SinusData] {
    var list = [SinusData]()
    for val in 1...20 {
        let values = generatePoints()
        let labels = getLabels()
        let item = SinusData(
            id: val, values: values, labels: labels, sinusName: "Lukas " + String(val), sinusTarget: "Target")
        list.append(item)
    }
    return list
}

struct GraphList_Previews: PreviewProvider {
    static var previews: some View {
        GraphList(gatherer: DataManager(), onlyFollowing: false)
    }
}
