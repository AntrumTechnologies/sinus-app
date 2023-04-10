//
//  UpdateWaveModel.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 10/04/2023.
//

import Foundation

class UpdateWaveModel: ObservableObject {
    let retrievable: RestRetrievable
    
    init(retrievable: RestRetrievable) {
        self.retrievable = retrievable
    }
    
    
    func updateWave(update: WaveUpdate) async -> String {
        let url = "https://lovewaves.antrum-technologies.nl/api/sinusvalue"
        
        // Convert date to string
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-d"
        var dateString = formatter.string(from: update.date)
        
        let parameters: [String: Any] = [
            "sinus_id": update.wave_id,
            "date": dateString,
            "value": update.value,
            "description": update.description]
        
        var request = RestApiHelper.createRequest(type: "PUT", url: url)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return error.localizedDescription
        }
        
        let urlSession = URLSession.shared
        var data: Data? = nil
        
        do {
            data = await self.retrievable.Retrieve(request: request)
        }
        catch {
            debugPrint("Error loading \(request.url) caused error \(error) with response \((String(bytes: data!, encoding: .utf8) ?? ""))")
        }
        
        let message = String(bytes: data!, encoding: .utf8) ?? ""
        return message.replacingOccurrences(of: "\"", with: "")
    }
    
}
