// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let openingHours = try? newJSONDecoder().decode(OpeningHours.self, from: jsonData)

import Foundation

// MARK: - OpeningHours
//struct OpeningHours: Codable {
//    var openNow: Bool
//    var periods: [Period]
//    var weekdayText: [String]
//
//    enum CodingKeys: String, CodingKey {
//        case openNow = "open_now"
//        case periods
//        case weekdayText = "weekday_text"
//    }
//}

struct OpeningHours: Codable {
    var openNow: Bool

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}
