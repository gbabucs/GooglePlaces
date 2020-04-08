// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let review = try? newJSONDecoder().decode(Review.self, from: jsonData)

import Foundation

// MARK: - Review
struct Review: Codable {
    var authorName: String
    var authorURL: String
    var language: String
    var profilePhotoURL: String
    var rating: Int
    var relativeTimeDescription, text: String
    var time: Int

    enum CodingKeys: String, CodingKey {
        case authorName = "author_name"
        case authorURL = "author_url"
        case language
        case profilePhotoURL = "profile_photo_url"
        case rating
        case relativeTimeDescription = "relative_time_description"
        case text, time
    }
}
