//
//  CompareModel.swift
//  SinuS
//
//  Created by Loe Hendriks on 26/03/2023.
//

import Foundation
import SwiftKeychainWrapper

private struct GraphDataPoint: Codable {
    let date: String
    let value: Int
    let deleted_at: String?
    let latitude: Double?
    let longitude: Double?
    let tags: String?
    let description: String?
}

@MainActor class CompareModel: ObservableObject {
    @Published var originPoints: [ChartPoint]
    @Published var comparePoints: [ChartPoint]
    
    init() {
        self.originPoints = []
        self.comparePoints = []
    }
    
    @MainActor func reload(originData: SinusData, compareName: String) async {
        //TODO Cleanup this reload method
        // Get origin points from origin data
        var originList = [ChartPoint]()
        var index = 0
        originData.values.forEach { value in
            originList.append(ChartPoint(label: "\(index)", value: value))
            index+=1
        }
        self.originPoints = originList
        
        // Get compare data based on name
        let nameAndTarget = compareName.components(separatedBy: " - ")
        let name = nameAndTarget[0]
        let target = nameAndTarget[1]

        // Get all users
        let url = URL(string: "https://lovewaves.antrum-technologies.nl/api/sinus")!
        let request = self.createRequest(url: url)
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        var users: [SinusUserData] = []
        do {
            (data, _) = try await urlSession.data(for: request)
            users = try JSONDecoder().decode([SinusUserData].self, from: data!)
            
        } catch {
            debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
        }

        // Get correct user
        let user = users.filter { userOption in
            return (userOption.name == name && userOption.date_name == target)
        }.first
        
        if (user == nil) {
            print("user is nill")
        }
        
        // Get user sinusData
        let userUrl = URL(string: "https://www.lovewaves.antrum-technologies.nl/api/sinusvalue/\(user!.id)")!
        let userRequest = self.createRequest(url: userUrl)
        
        do {
            (data, _) = try await urlSession.data(for: userRequest)
            let graphPoints = try JSONDecoder().decode([GraphDataPoint].self, from: data!)
            
            var compareList = [ChartPoint]()
            index = 0
            graphPoints.forEach { gp in
                compareList.append(ChartPoint(label: "\(index)", value: gp.value))
                index+=1
            }
            
            self.comparePoints = compareList
            
        } catch {
            debugPrint("Error loading \(url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
        }
        
    }
    
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let bearerToken: String = KeychainWrapper.standard.string(forKey: "bearerToken") ?? ""
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}
