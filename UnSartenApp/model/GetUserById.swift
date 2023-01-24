//
// Created by Ivan Nieto on 19/01/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getUserByID = try? JSONDecoder().decode(GetUserByID.self, from: jsonData)

import Foundation

// MARK: - GetUserByID
struct GetUserByID: Codable {
    let data: GetUserByIDDataClass
}

// MARK: - DataClass
struct GetUserByIDDataClass: Codable {
    let getUserByID: GetUserByIDClass
    let error: JSONNull?

    enum CodingKeys: String, CodingKey {
        case getUserByID = "GetUserById"
        case error
    }
}

// MARK: - GetUserByIDClass
struct GetUserByIDClass: Codable {
    let userID, email, firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case email, firstName, lastName
    }
}
