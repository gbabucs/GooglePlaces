//
//  PlacesViewModel.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import CoreLocation

class PlacesViewModel {
    
    var latitude: Double
    var longitude: Double
    var radius: String
    var type: String
    var places: [PlacesResult] = []
    
    init(places: [PlacesResult] = [],
         latitude: Double = 0.0,
         longitude: Double = 0.0,
         radius: String = "",
         type: String = "") {
        self.places = places
        self.latitude = latitude
        self.longitude = longitude
        self.radius = radius
        self.type = type
    }
    
    func getPlaces(completion: @escaping (Bool) -> ()) {
        
        let queryParameter = "location=\(latitude),\(longitude)&radius=\(radius)&type=\(type)"
        
        DataAdapter.shared.fetchPlaceSearch(parameters: queryParameter) { response, error in
            
            guard let placesResponse = response else { return completion(true) }
            
            self.places = placesResponse.results
        
            for index in self.places.indices {
                self.places[index].calculateDistanceToStore(latitude: self.latitude, longitude: self.longitude)
            }
    
            if error != nil || placesResponse.results.count == 0 {
                completion(true)
            }
            
             completion(false)
        }
    }
    
    func sortBy(type: String) {
        let sorting = Sorting(rawValue: type)
        
        switch sorting {
        case .ascending: self.places = self.places.sorted { $0.name < $1.name }
        case .descending: self.places = self.places.sorted { $0.name > $1.name }
        case .open: self.places = self.places.sorted { $0.openingHours.openNow && !$1.openingHours.openNow }
        case .closed: self.places = self.places.sorted { !$0.openingHours.openNow && $1.openingHours.openNow }
        case .distance: self.places = self.places.sorted { $0.distance < $1.distance }
        case .none: break
        }
    }
    
}

extension PlacesResult {
    
    mutating func calculateDistanceToStore(latitude: Double, longitude: Double) {
        let location: CLLocation =  CLLocation(latitude: latitude, longitude: longitude)
        let storeCoordinate: CLLocation = CLLocation(latitude: geometry.location.lat, longitude: geometry.location.lng)
        let distanceInMeter = location.distance(from: storeCoordinate)
        let distanceinKiloMeter = distanceInMeter/1000
        
        print("place name \(name)")
        print ("distance \(distanceinKiloMeter)")
        
        distance = distanceinKiloMeter
    }
}
