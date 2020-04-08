// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let viewport = try? newJSONDecoder().decode(Viewport.self, from: jsonData)

import Foundation

// MARK: - Viewport
struct Viewport: Codable {
    var northeast, southwest: Location
}
