//
//  AlamofireImageSource.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 08/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireImage
import ImageSlideshow

/// Input Source to image using Alamofire
public class AlamofireImageSource: NSObject, InputSource {
    
    /// url to load
    public var url: URL
    
    /// placeholder used before image is loaded
    public var placeholder: UIImage?
    
    /// Initializes a new source with a URL
    /// - parameter url: a url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    public init(url: URL, placeholder: UIImage? = nil) {
        self.url = url
        self.placeholder = placeholder
        super.init()
    }
    
    /// Initializes a new source with a URL string
    /// - parameter urlString: a string url to load
    /// - parameter placeholder: a placeholder used before image is loaded
    public init?(urlString: String, placeholder: UIImage? = nil) {
        if let validUrl = URL(string: urlString) {
            self.url = validUrl
            self.placeholder = placeholder
            super.init()
        } else {
            return nil
        }
    }
    
    public func load(to imageView: UIImageView, with callback: @escaping (UIImage?) -> Void) {
        imageView.af.setImage(withURL: self.url, placeholderImage: placeholder, filter: nil, progress: nil) { response in
            imageView.image = response.value
            if let value = response.value {
                callback(value)
            }
        }
    }
}
