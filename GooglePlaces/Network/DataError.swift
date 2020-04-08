//
//  DataError.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}
