//
//  FeedItemModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 12/03/2023.
//

import SwiftUI
import SwiftKeychainWrapper
import Kingfisher

@MainActor class FeedItemModel: ObservableObject {
    let retrievable: RestRetrievable
    
    @Published var waveData: SinusData
    @Published var chartPoints: [ChartPoint]
    @Published var pointA: Int
    @Published var pointB: Int
    @Published var percentage: Int
    @Published var color: Color
    @Published var icon: Image
    @Published var avatar: KFImage
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
        self.waveData = SinusData(id: 0, values: [0], labels: [""], descriptions: ["Description"], sinusName: "", sinusTarget: "")
        self.chartPoints = [ChartPoint(label: "", value: 0)]
        self.pointA = 0
        self.pointB = 0
        self.percentage = 0
        self.color = .gray
        self.icon = Image(systemName: "square.fill")
        // TODO: do not run avatar download on main thread, use a local placeholder avatar instead
        let url: URL = URL(string: "\(LoveWavesApp.baseUrl)/avatars/placeholder.jpg")!
        self.avatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
    }
    
    private struct GraphDataPoint: Codable {
        let date: String
        let value: Int
        let deleted_at: String?
        let latitude: Double?
        let longitude: Double?
        let tags: String?
        let description: String?
    }
    
    @MainActor func reload(userData: SinusUserData) async {
        let url = URL(string: "\(LoveWavesApp.baseUrl)/api/sinusvalue/\(userData.id)")!
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            data = await self.retrievable.Retrieve(request: request)
            print("user: \(userData.id) data: \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
            
            let graphDataPoints = try JSONDecoder().decode([GraphDataPoint].self, from: data ?? Data())
            var values = [Int]()
            var labels = [String]()
            var descriptions = [String]()
            graphDataPoints.forEach { point in
                values.append(point.value)
                labels.append(point.date)
                descriptions.append(point.description ?? "")
            }
            
            self.waveData = SinusData(
                id: userData.id,
                values: values,
                labels: labels,
                descriptions: descriptions,
                sinusName: userData.name,
                sinusTarget: userData.date_name)
            
            self.chartPoints = [ChartPoint]()
            if self.waveData.values.count > 0 {
                for val in 0...self.waveData.values.count - 1 {
                    self.chartPoints.append(ChartPoint(label: self.waveData.labels[val], value: self.waveData.values[val]))
                }
            }
            
            if self.waveData.values.count > 1 {
                self.pointA = self.waveData.values[self.waveData.values.count - 2]
            } else {
                self.pointA = 0
            }
            
            if self.waveData.values.count > 1 {
                self.pointB = self.waveData.values[self.waveData.values.count - 1]
            } else {
                self.pointB = 0
            }
            
            self.percentage = self.pointB - self.pointA
            
            if self.percentage > 0 {
                self.color = .green
            } else if self.percentage < 0 {
                self.color = .red
            } else {
                self.color = .gray
            }
            
            if self.percentage > 0 {
                self.icon = Image(systemName: "arrowtriangle.up.fill")
            } else if self.percentage < 0 {
                self.icon = Image(systemName: "arrowtriangle.down.fill")
            } else {
                self.icon = Image(systemName: "square.fill")
            }
            
            // Create avatar image
            let avatar: String = userData.avatar ?? ""
            if (avatar != "") {
                let url: URL = URL(string: "\(LoveWavesApp.baseUrl)/" + avatar)!
                self.avatar = KFImage.url(url).setProcessor(DownsamplingImageProcessor(size: CGSize(width: 100, height: 100)))
            }
        } catch {
            debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data ?? Data(), encoding: .utf8) ?? ""))")
        }
    }
}
