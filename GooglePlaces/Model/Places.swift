// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let places = try? newJSONDecoder().decode(Places.self, from: jsonData)

import Foundation

// MARK: - Places
struct Places: Codable {
    var htmlAttributions: [JSONAny]
    var results: [PlacesResult]
    var status: String

    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case results, status
    }
}
