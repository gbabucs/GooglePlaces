//
//  PlacesResultCell.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit
//import Cosmos

class PlacesResultCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var openNowLabel: UILabel!
    //@IBOutlet weak var starRatingView: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // starRatingView.settings.fillMode = .precise
       // starRatingView.settings.updateOnTouch = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = ""
        addressLabel.text = ""
        distanceLabel.text = ""
        openNowLabel.text = ""
    }
}

//--------------------------------------------------------------------------
// MARK: - Cell
//--------------------------------------------------------------------------

extension PlacesResultCell: Cell {
    
    typealias T = PlacesResult
    
    func configure(with value: PlacesResult) {
        nameLabel.text = value.name
        addressLabel.text = value.name
        distanceLabel.text = value.distance.formatDistanceInKM
        openNowLabel.changeLabelColor(value.openingHours.openNow)
       // starRatingView.backgroundColor = .clear
        //starRatingView.rating = value.rating
    }
}
