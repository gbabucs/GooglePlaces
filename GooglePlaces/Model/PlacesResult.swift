// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let result = try? newJSONDecoder().decode(Result.self, from: jsonData)

import Foundation

// MARK: - Result

struct PlacesResult: Codable {
    var geometry: Geometry
    var icon: String
    var id, name: String
    var openingHours: OpeningHours
    var photos: [Photo]
    var placeID: String
    var plusCode: PlusCode
    var rating: Double
    var reference, scope: String
    var types: [String]
    var userRatingsTotal: Int
    var vicinity: String
    var priceLevel: Int?
    var reviews: [Review]?
    var distance: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case geometry, icon, id, name
        case openingHours = "opening_hours"
        case photos
        case placeID = "place_id"
        case plusCode = "plus_code"
        case rating, reference, reviews, scope, types
        case userRatingsTotal = "user_ratings_total"
        case vicinity
        case priceLevel = "price_level"
    }
}
