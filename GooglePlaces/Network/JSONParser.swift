//
//  JSONParser.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

class JSONParser {
    
    typealias result<T> = (Result<[T], Error>) -> Void
    
    func downloadList<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping result<T>) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: [T] = try JSONDecoder().decode([T].self, from: data)
                        completion(.success(decodedData))
                    }
                    catch {
                        completion(.failure(DataError.decodingError))
                    }
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
        }.resume()
    }
    
}
