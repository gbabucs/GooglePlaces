// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let placeDetail = try? newJSONDecoder().decode(PlaceDetail.self, from: jsonData)

import Foundation

// MARK: - PlaceDetail
struct PlaceDetail: Codable {
    var htmlAttributions: [JSONAny]
    var result: PlacesResult
    var status: String

    enum CodingKeys: String, CodingKey {
        case htmlAttributions = "html_attributions"
        case result, status
    }
}
