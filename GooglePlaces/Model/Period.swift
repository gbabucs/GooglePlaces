// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let period = try? newJSONDecoder().decode(Period.self, from: jsonData)

import Foundation

// MARK: - Period
struct Period: Codable {
    var close, periodOpen: Close

    enum CodingKeys: String, CodingKey {
        case close
        case periodOpen = "open"
    }
}
