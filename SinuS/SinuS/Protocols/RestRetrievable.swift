//
//  PFeedItem.swift
//  SinuS
//
//  Created by Loe Hendriks on 18/03/2023.
//

import Foundation

protocol RestRetrievable {
    func Retrieve(request: URLRequest) async -> Data?
}
