//
//  PlacesDetailViewModelTests.swift
//  GooglePlacesTests
//
//  Created by ThunderFlash on 08/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest

class PlacesDetailViewModelTests: XCTestCase {
    
    var viewModel: PlacesDetailViewModel!
    
    override func setUp() {
        //TODO: add mock json
        guard let placeDetail = valuesFromJSON(name: "PlaceDetail") else { return }
        
        viewModel = PlacesDetailViewModel(place: placeDetail)
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    //FIXME: - api error for place detail
    
//    func testViewModelIsEmpty() {
//        XCTAssertNotEqual(self.viewModel.place.name, "", "Expected both viewModel and model have different values")
//        XCTAssertEqual(self.viewModel.place.photos.count, 0, "Expected both viewModel and model have 0 values")
//    }
    
    func valuesFromJSON(name: String) -> PlacesResult? {
        
        guard let data = FileManager.readJsonFile(forResource: name)
            else {
                XCTAssertFalse(false, "Can't get data from Places.json")
                return nil
        }
        
        guard let placeResponse = DataAdapter.shared.processData(type: PlaceDetail.self, response: data)
            else {
                XCTAssertFalse(false, "Can't parse json")
                return nil
        }
        
        return placeResponse.result
    }
}
