//
//  GooglePlacesAPI.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation


import Foundation
import Alamofire

struct GooglePlacesAPIConstant {
    //static let apiKey = "AIzaSyAPQ-8GFc2uPGAXWEp7kCb2_egeBN0rCEE"
    static let apiKey = "AIzaSyBa7kmy9kiiIpE3tXIHdjNcNa5ytxVCC2Y"
}

enum GooglePlacesAPI {
    case search(query: String)
    case detail(query: String)
    case photo(query: String)
}

//--------------------------------------------------------------------------
// MARK: - EndPoint
//--------------------------------------------------------------------------

extension GooglePlacesAPI: EndPoint {

    var baseURL: String {
        switch self {
        case .search:
            return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        case .detail:
            return "https://maps.googleapis.com/maps/api/place/details/json?"
        case .photo:
            return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var apiKey: String {
        return GooglePlacesAPIConstant.apiKey
    }
    
    var relativeURL: String {
        switch self {
        case .search(let query),
             .detail(let query),
             .photo(let query):
            return baseURL + query + "&key=\(apiKey)"
        }
    }
}
