//
//  UserData.swift
//  SinuS
//
//  Created by Loe Hendriks on 08/01/2023.
//

import Foundation

public struct UserData: Codable {
    let id: Int
    let name: String
    let email: String
    let email_verified_at: String?
    let created_at: String?
    let updated_at: String?
    let avatar: String?
}
