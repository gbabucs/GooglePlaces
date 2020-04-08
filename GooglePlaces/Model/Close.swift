// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let close = try? newJSONDecoder().decode(Close.self, from: jsonData)

import Foundation

// MARK: - Close
struct Close: Codable {
    var day: Int
    var time: String
}
