//
//  NetworkState.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 08/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import Alamofire

class NetworkState {
    
    class var isConnected: Bool {
        guard let reachabilityManager = NetworkReachabilityManager() else { return false }
        
        return reachabilityManager.isReachable
    }
}
