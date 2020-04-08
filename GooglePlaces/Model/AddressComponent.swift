// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addressComponent = try? newJSONDecoder().decode(AddressComponent.self, from: jsonData)

import Foundation

// MARK: - AddressComponent
struct AddressComponent: Codable {
    var longName, shortName: String
    var types: [String]

    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}
