//
//  Endpoint.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import Alamofire

protocol EndPoint {
    var baseURL: String { get }
    var httpMethod: HTTPMethod { get }
    var relativeURL: String { get }
}
