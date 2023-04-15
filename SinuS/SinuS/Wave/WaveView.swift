//
//  LineChart2.swift
//  SinuS
//
//  Created by Loe Hendriks on 17/09/2022.
//

import SwiftUI
import Charts
import Kingfisher

struct ChartPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Int
}

struct WaveView: View {
    private let user: SinusUserData
    private let avatar: KFImage
    @ObservedObject var waveModel = FeedItemModel(retrievable: ExternalRestRetriever())
    @ObservedObject var followingModel = FollowingModel()
    @ObservedObject var contentModel = ContentViewModel(retrievable: ExternalRestRetriever())
    @Environment(\.presentationMode) var presentationMode
    
    private static var following = false

    init(user: SinusUserData) {
        self.user = user
        // Create avatar image
        // TODO: do not run avatar download on main thread, use a local placeholder avatar instead
        let avatar: String = user.avatar ?? "avatars/placeholder.jpg"
        let url: URL = URL(string: "\(LoveWavesApp.baseUrl)/" + avatar)!
        self.avatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }

    var body: some View {
        VStack {
            HeaderView(
                user: self.user,
                subtext: self.waveModel.waveData.sinusTarget,
                avatar: self.avatar,
                scaleFactor: 1,
                following: self.followingModel.isFollowing,
                loggedIn: self.contentModel.contentViewModel.loggedIn,
                followingModel: self.followingModel)

            ScrollView(.vertical) {
                Divider()

                if (self.waveModel.chartPoints.count > 0) {
                    ChartView(points: self.waveModel.chartPoints)
                    
                    CompareButtonView(data: self.waveModel.waveData)
                        .padding(.bottom)
                    
                    Divider()
                    
                    StatisticsView(data: self.waveModel.waveData)
                    
                    Divider()
                    
                    HistoryView(
                        descriptions: self.waveModel.waveData.descriptions,
                        dates: self.waveModel.waveData.labels,
                        values: self.waveModel.waveData.values)
                }
                else{
                    NoDataView(scale: 1, useLogo: true)
                }

            }
        }
        .task {
            await self.waveModel.reload(userData: user)
            await self.followingModel.reload(user: self.user)
            await self.contentModel.reload()
        }
        .refreshable {
            Task{
                await self.followingModel.reload(user: self.user)
                await self.waveModel.reload(userData: user)
                await self.contentModel.reload()
            }
          
        }
        .toolbar(.visible, for: ToolbarPlacement.navigationBar)
        .toolbarBackground(Style.AppColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button("Back"){self.presentationMode.wrappedValue.dismiss()})
    }
}

struct LineChart2_Previews: PreviewProvider {
    static var previews: some View {
        WaveView(
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
