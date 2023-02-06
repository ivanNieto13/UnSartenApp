//
//  SaveOrderDataViewModel.swift
//  UnSartenApp
//
//  Created by Ivan Nieto on 05/02/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let saveOrderData = try? JSONDecoder().decode(SaveOrderData.self, from: jsonData)

import Foundation

// MARK: - SaveOrderData
struct SaveOrderData: Codable {
    let data: SODataClass
}

// MARK: - DataClass
struct SODataClass: Codable {
    let SaveOrderData: SaveOrderDataClass
    let error: JSONNull?

    enum CodingKeys: String, CodingKey {
        case SaveOrderData = "SaveOrderData"
        case error
    }
}

// MARK: - SaveOrderDataClass
struct SaveOrderDataClass: Codable {
    let userId, orderName: String
    let budget: Double
    let persons: Int
    let orderPicture: JSONNull?
    let orderStatus, author, date, optionalIngredients: String

    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case orderName, budget, persons, orderPicture, orderStatus, author, date, optionalIngredients
    }
}
