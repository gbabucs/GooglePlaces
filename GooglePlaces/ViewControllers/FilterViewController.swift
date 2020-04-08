//
//  FilterViewController.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 05/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit
import DLRadioButton

class FilterViewController: UIViewController {

    @IBOutlet var bar: DLRadioButton!
    @IBOutlet var cafeBtn: DLRadioButton!
    @IBOutlet weak var restaurant: DLRadioButton!

    var selectedType = "restaurant"
    var selectedRadius = "2.0"
    
    var filterDict = Dictionary<String, String>()
    weak var filterDelegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filter"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        configureFilter()
    }
    
    func configureFilter() {
        if let filterType = filterDict["type"] {
            switch filterType {
            case "bar": bar.isSelected = true
            case "cafe": cafeBtn.isSelected = true
            case "restaurant": restaurant.isSelected = true
            default: break
            }
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func apply(_ sender: Any) {
        selectedType = bar.selected()?.titleLabel?.text ?? selectedType
        filterDict["type"] = selectedType
        
        dismiss(animated: true) { [unowned self] in
            self.filterDelegate?.apply(self.filterDict)
        }
    }
    
}
