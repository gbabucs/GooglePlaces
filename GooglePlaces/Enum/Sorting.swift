//
//  Sorting.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 08/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

enum Sorting: String {
    case ascending
    case descending
    case open
    case closed
    case distance
    
    var displayName: String {
        return self.rawValue.capitalized
    }
}
