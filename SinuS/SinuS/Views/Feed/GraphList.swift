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
    let viewModel: FeedViewModel

    @State private var feed: [SinusUserData] = []

    init(gatherer: DataManager, viewModel: FeedViewModel, onlyFollowing: Bool) {
        self.gatherer = gatherer
        self.onlyFollowing = onlyFollowing
        self.viewModel = viewModel
        _feed = State(initialValue: self.viewModel.feedModel)
    }

    var body: some View {
        ZStack {
            ZStack {
                Text("")

                List(self.feed, id: \.id) { user in
                    let data = self.gatherer.gatherSingleData(user: user)

                    NavigationLink(
                        destination: WaveView(gatherer: self.gatherer, user: user, data: data),
                        label: {
                            Concept1(userData: user, data: data)
                        })
                }
                .refreshable {
                        self.viewModel.retrieveFollowingData(onlyFollowing: self.onlyFollowing)
                        self.feed = self.viewModel.feedModel
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
       // GraphList(gatherer: DataManager(), onlyFollowing: false)
        GraphList(gatherer: DataManager(), viewModel: FeedViewModel(), onlyFollowing: false)
    }
}
