//
//  PlacesDetailViewModel.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import UIKit

class PlacesDetailViewModel {
    
    var place: PlacesResult
    var reviews: [Review] = []
    
    init(place: PlacesResult) {
        self.place = place
    }
    
    func getPlaceDetail(completion: @escaping (Bool) -> ()) {
        let queryParameter = "placeid=\(place.placeID)"
        
        DataAdapter.shared.fetchPlaceDetail(parameters: queryParameter) { response, error in
            if let place = response?.result {
                self.place = place
                self.reviews = self.place.reviews ?? []
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func loadPlaceImages() -> [AlamofireImageSource] {
        var remoteImageSource = [AlamofireImageSource]()
        let defaultImage = UIImage(named:"placeholder")
        
        for photo in place.photos {
            let photoUrlString = String(format: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%@&key=%@", photo.photoReference, GooglePlacesAPIConstant.apiKey)
            
            if let source = AlamofireImageSource(urlString: photoUrlString, placeholder: defaultImage) {
                remoteImageSource.append(source)
            }
        }
        
        return remoteImageSource
    }
}
