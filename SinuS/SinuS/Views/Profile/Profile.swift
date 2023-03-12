//
//  Personal.swift
//  SinuS
//
//  Created by Patrick van Broeckhuijsen on 11/03/2023.
//

import Foundation

struct Profile: Identifiable, Codable {
    var id: Int
    var name: String
    var email: String
    var email_verified_at: String?
    var created_at: String
    var updated_at: String?
    var avatar: String?
    var fcm_token: String?
}
