//
//  GooglePlacesAPITests.swift
//  GooglePlacesTests
//
//  Created by ThunderFlash on 08/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest
import Alamofire

class GooglePlacesAPITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_API_values() {
        let parameter = "location=52.311420,4.870087&radius=500&type=restaurant&keyword=sushi"
        let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?"
        let apiKey = "AIzaSyA1Zv-60eJLWvbwYljtysHT_zdSYWgTj5Q"
        let httpMethod = HTTPMethod.get
        let relativeURL = baseURL + "\(parameter)&key=\(apiKey)"
        
        let userSearch = GooglePlacesAPI.search(query: parameter)
        
        XCTAssertEqual(userSearch.baseURL, baseURL, "Expected both have same \(baseURL)")
        XCTAssertEqual(userSearch.httpMethod, httpMethod, "Expected both have same \(httpMethod)")
        XCTAssertEqual(userSearch.apiKey, apiKey, "Expected both have same")
        XCTAssertEqual(userSearch.relativeURL, relativeURL, "Expected both have same")
        
    }

}
