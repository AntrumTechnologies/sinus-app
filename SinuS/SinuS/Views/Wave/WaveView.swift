//
//  LineChart2.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/09/2022.
//

import SwiftUI
import Charts

struct ChartPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Int
}

struct WaveView: View {
    private let gatherer: DataManager
    private let user: SinusUserData
    @ObservedObject var waveModel = FeedItemModel(retrievable: ExternalRestRetriever())
    
    private static var following = false

    init(gatherer: DataManager, user: SinusUserData) {
        self.gatherer = gatherer
        self.user = user
    }

    var body: some View {
        VStack {
            HeaderWithSubTextView(
                user: self.user,
                subtext: self.waveModel.waveData.sinusTarget,
                avatar: Image("Placeholder"),
                scaleFactor: 1,
                gatherer: self.gatherer)

            ScrollView(.vertical) {
                Divider()

                if (self.waveModel.chartPoints.count > 0) {
                    ChartView(points: self.waveModel.chartPoints)
                        .frame(height: 450)
                    
                    CompareButtonView(gatherer: self.gatherer, data: self.waveModel.waveData)
                        .padding(.bottom)
                    
                    Divider()
                    
                    StatisticsView(data: self.waveModel.waveData)
                    
                    Divider()
                    
                    HistoryView(descriptions: self.waveModel.waveData.descriptions, dates: self.waveModel.waveData.labels)
                }
                else{
                    NoDataView(scale: 1, useLogo: true)
                }

            }
        }
        .task {
            await self.waveModel.reload(userData: user)
        }
        .refreshable {
            await self.waveModel.reload(userData: user)
        }
        .toolbar(.visible, for: ToolbarPlacement.navigationBar)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

struct LineChart2_Previews: PreviewProvider {
    static var previews: some View {
        WaveView(
            gatherer: DataManager(),
            user: SinusUserData(
            id: 1,
            name: "Lukas",
            user_id: 1,
            date_name: "Target",
            created_at: "",
            updated_at: "",
            deleted_at: "",
            archived: 0,
            avatar: "",
            following: false))
    }
}
