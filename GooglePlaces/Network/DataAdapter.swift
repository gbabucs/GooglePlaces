//
//  DataAdapter.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

import Foundation

class DataAdapter {
    
    static let shared = DataAdapter()
    
    private init() {}
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias GetPlaceCompletionHandler = (Places?, Error?) -> ()
    typealias GetPlaceDetailCompletionHandler = (PlaceDetail?, Error?) -> ()
    typealias GooglePlacesResult<T> = (Result<T?, Error>) -> ()
    
    //--------------------------------------------------------------------------
    // MARK: - Functions
    //--------------------------------------------------------------------------
    
    /// Get Place response using  `fetchPlaceSearch`  to
    /// the provided `destination` using the `parameters`
    ///
    /// - Parameters:
    ///   - parameters:    The `String` value.
    ///   - completion:    The `GetCompletionHandler` value
    
    func fetchPlaceSearch(parameters: String, completion: @escaping GetPlaceCompletionHandler) {
        let service = GooglePlacesAPIService(api: .search(query: parameters))
        
        self.fetchData(from: service, type: Places.self) { listOfPlaces in
            switch listOfPlaces {
            case .success(let places):
                return completion(places, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    /// Get Place Detail response using  `fetchPlaceDetail`  to
    /// the provided `destination` using the `parameters`
    ///
    /// - Parameters:
    ///   - parameters:    The `String` value.
    ///
    
    func fetchPlaceDetail(parameters: String, completion: @escaping GetPlaceDetailCompletionHandler) {
        let service = GooglePlacesAPIService(api: .detail(query: parameters))
        
        self.fetchData(from: service, type: PlaceDetail.self) { placeDetails in
            switch placeDetails {
            case .success(let placeInfo):
                return completion(placeInfo, nil)
            case .failure(let error):
                return completion(nil, error)
            }
        }
    }
    
    //--------------------------------------------------------------------------
    // MARK: - Private functions
    //--------------------------------------------------------------------------
    
    private func fetchData<T: Codable>(from request: GooglePlacesAPIService, type: T.Type , completion: @escaping GooglePlacesResult<T>) {
        request.getRequest { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let response):
                let places = self.processData(type: type, response: response)
                completion(.success(places))
            }
        }
    }
    
    func processData<T: Codable>(type: T.Type, response: Data?) -> T? {
        var result: T? = nil
        
        if let jsondata = response {
            do {
                let object = try JSONDecoder().decode(T.self, from: jsondata)
                
                result = object
                
            } catch let jsonError {
                print("Error decoding Json Questons", jsonError)
            }
        }
        
        return result
    }
}
