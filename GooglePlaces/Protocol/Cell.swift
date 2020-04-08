//
//  Cell.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation

protocol Cell: class {
    
    static var reuseIdentifier: String { get }
    associatedtype Item
    func configure(with value: Item)
}

extension Cell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    func configure(with value: Item) {}
}
