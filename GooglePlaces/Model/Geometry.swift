// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let geometry = try? newJSONDecoder().decode(Geometry.self, from: jsonData)

import Foundation

// MARK: - Geometry
struct Geometry: Codable {
    var location: Location
    var viewport: Viewport
}
