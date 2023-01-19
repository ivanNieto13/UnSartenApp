//
// Created by Ivan Nieto on 16/01/23.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let verifyCode = try? JSONDecoder().decode(VerifyCode.self, from: jsonData)

import Foundation

// MARK: - VerifyCode
struct VerifyCode: Codable {
    let data: VCDataClass
}

// MARK: - DataClass
struct VCDataClass: Codable {
    let verifyCode: VerifyCodeClass
    let error: JSONNull?

    enum CodingKeys: String, CodingKey {
        case verifyCode = "VerifyCode"
        case error
    }
}

// MARK: - VerifyCodeClass
struct VerifyCodeClass: Codable {
    let code: String
    let isValid: Bool
}
