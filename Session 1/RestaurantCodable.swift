//
//  RestaurantCodable.swift
//  Session 1
//
//  Created by Karim Karimov on 28.06.22.
//

import Foundation

struct RestaurantCodable: Decodable {
    let id: String
    let createdAt: String
    let name: String
    let distance: Int
    let rate_count: Int
    let mid_price: String
}
