//
// Created by Ivan Nieto on 12/01/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let verifyNumber = try? JSONDecoder().decode(VerifyNumber.self, from: jsonData)

import Foundation

// MARK: - VerifyNumber
struct VerifyNumber: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let verifyNumber: VerifyNumberClass
    let error: JSONNull?

    enum CodingKeys: String, CodingKey {
        case verifyNumber = "VerifyNumber"
        case error
    }
}

// MARK: - VerifyNumberClass
struct VerifyNumberClass: Codable {
    let phoneNumber: String
    let isVerified: Bool
    let userID: String?

    enum CodingKeys: String, CodingKey {
        case phoneNumber, isVerified
        case userID = "userId"
    }
}