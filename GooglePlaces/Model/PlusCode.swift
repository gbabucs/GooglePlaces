// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let plusCode = try? newJSONDecoder().decode(PlusCode.self, from: jsonData)

import Foundation

// MARK: - PlusCode
struct PlusCode: Codable {
    var compoundCode, globalCode: String

    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}
