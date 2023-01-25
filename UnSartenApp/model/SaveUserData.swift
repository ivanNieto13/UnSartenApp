//
// Created by Ivan Nieto on 12/01/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let saveUserData = try? JSONDecoder().decode(SaveUserData.self, from: jsonData)

import Foundation

// MARK: - SaveUserData
struct SaveUserData: Codable {
    let data: SUDataClass
}

// MARK: - SUDataClass
struct SUDataClass: Codable {
    let saveUserData: SaveUserSUDataClass
    let error: JSONNull?

    enum CodingKeys: String, CodingKey {
        case saveUserData = "SaveUserData"
        case error
    }
}

// MARK: - SaveUserSUDataClass
struct SaveUserSUDataClass: Codable {
    let userID, email, firstName, lastName, phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case email, firstName, lastName, phoneNumber
    }
}

