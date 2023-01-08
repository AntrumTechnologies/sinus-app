//
//  SinusUserData.swift
//  SinuS
//
//  Created by Loe Hendriks on 25/09/2022.
//

import Foundation

public struct SinusUserData: Codable {
    let id: Int
    let name: String
    let user_id: Int
    let date_name: String
    let created_at: String?
    let updated_at: String?
    let deleted_at: String?
    let archived: Int
}
