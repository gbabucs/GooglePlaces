//
//  GooglePlacesAPIService.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 05/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import Alamofire


class GooglePlacesAPIService {
    
    private let api: GooglePlacesAPI
    
    //--------------------------------------------------------------------------
    // MARK: - Typealias
    //--------------------------------------------------------------------------
    
    typealias ResponseHandler = (Result<Data, Error>) -> Void
    
    init(api: GooglePlacesAPI) {
        self.api = api
    }
    
    //--------------------------------------------------------------------------
    // MARK: - API Requests
    //--------------------------------------------------------------------------
    
    /// Get request  using  `getRequest`
    ///
    /// - Parameters:
    ///   - completion:    The `ResponseHandler` value
    
    func getRequest(completion: @escaping ResponseHandler)  {
        
        let url = api.relativeURL
        let httpMethod = api.httpMethod
        
        print(url)
        
        AF.request(url, method: httpMethod).validate().responseJSON { response in
            
            print(response)
            
            switch response.result {
            case .success:
                if let data = response.data {
                    completion(.success(data))
                } else {
                    completion(.failure(DataError.invalidData))
                }
            case .failure(let error):
                print("Failed request with given url: \(url)", error)
                completion(.failure(error))
            }
        }
    }
}
