//
//  Utility.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 07/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with title: String, detail message: String) {
        let alertController = UIAlertController(title: title , message: message , preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIStoryboardSegue {
    static let showFilterIdentifier = "showFilter"
    static let showDetailIdentifier = "showDetail"
}

extension UILabel {

    func changeLabelColor(_ isOpenStatus: Bool) {
        if isOpenStatus {
            self.text = "OPEN"
            self.textColor = UIColor(hue: 0.2778, saturation: 0.93, brightness: 0.62, alpha: 1.0)
        } else {
            self.text = "CLOSED"
            self.textColor = .red
        }
    }
}

extension Double {
    var formatDistanceInKM: String {
        return "\(String(format:"%.1f", self)) km"
    }
}
