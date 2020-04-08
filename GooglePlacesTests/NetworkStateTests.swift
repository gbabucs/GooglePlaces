//
//  NetworkStateTests.swift
//  GooglePlacesTests
//
//  Created by ThunderFlash on 08/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest

class NetworkStateTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNetworkStateReachable() {
        if NetworkState.isConnected {
            XCTAssertTrue(NetworkState.isConnected, "Internet Connection Available!")
        } else {
            XCTAssertFalse(NetworkState.isConnected, "Internet Connection not Available!")
        }
    }
    
    
}
