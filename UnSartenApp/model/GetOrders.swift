//
// Created by Ivan Nieto on 05/02/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getOrders = try? JSONDecoder().decode(GetOrders.self, from: jsonData)

import Foundation

// MARK: - GetOrders
struct GetOrders: Codable {
    let data: GODataClass
}

// MARK: - DataClass
struct GODataClass: Codable, Hashable {
    static func ==(lhs: GODataClass, rhs: GODataClass) -> Bool {
        return lhs.getOrders == rhs.getOrders && lhs.error == rhs.error
    }

    let getOrders: [GetOrder]
    let error: JSONNull?

    enum CodingKeys: String, CodingKey {
        case getOrders = "GetOrders"
        case error
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(getOrders)
        hasher.combine(error)
    }
}

// MARK: - GetOrder
struct GetOrder: Codable, Hashable {
    let userId, orderName: String
    let budget, persons: Int
    let orderPicture: JSONNull?
    let orderStatus, author, date, optionalIngredients: String

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case orderName, budget, persons, orderPicture, orderStatus, author, date, optionalIngredients
    }
}

