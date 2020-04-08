// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photo = try? newJSONDecoder().decode(Photo.self, from: jsonData)

import Foundation

// MARK: - Photo
struct Photo: Codable {
    var height: Int
    var htmlAttributions: [String]
    var photoReference: String
    var width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
        case photoReference = "photo_reference"
        case width
    }
}
