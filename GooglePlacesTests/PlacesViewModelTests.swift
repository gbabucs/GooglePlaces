//
//  PlacesViewModelTests.swift
//  GooglePlacesTests
//
//  Created by ThunderFlash on 08/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import XCTest

class PlacesViewModelTests: XCTestCase {
    
    var viewModel: PlacesViewModel!
    
    override func setUp() {
        viewModel = PlacesViewModel()
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testViewModelPlacesIsEmpty() {
        let places = valuesFromJSON(name: "InvalidText")
        
        self.viewModel.places = places
        
        XCTAssertNotEqual(self.viewModel.places.count, 4, "Expected both viewModel and model have different values")
        
        XCTAssertEqual(self.viewModel.places.count, 0, "Expected both viewModel and model have 0 values")
    }
    
    func testViewModelPlacesIsNotEmpty() {
        let places = valuesFromJSON(name: "Places")
        
        self.viewModel.places = places
        
        XCTAssertEqual(self.viewModel.places.count, 0, "Expected both viewModel and model have same data")
    }
    
    
    func valuesFromJSON(name: String) -> [PlacesResult] {
        var placesResults = [PlacesResult]()
        
        guard let data = FileManager.readJsonFile(forResource: name)
            else {
                XCTAssertFalse(false, "Can't get data from Places.json")
                return placesResults
        }
        
        guard let placesResponse = DataAdapter.shared.processData(type: Places.self, response: data)
            else {
                XCTAssertFalse(false, "Can't parse json")
                return placesResults
        }
        
        placesResults = placesResponse.results
        
        return placesResults
    }
}

extension FileManager {
    static func readJsonFile(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: PlacesViewModelTests.self)
        
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                return data
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
