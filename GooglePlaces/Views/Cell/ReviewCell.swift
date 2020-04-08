//
//  ReviewCell.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit
import Cosmos
import AlamofireImage

class ReviewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var starRatingView: CosmosView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var reviewDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        starRatingView.settings.fillMode = .precise
        starRatingView.settings.updateOnTouch = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImage.image = nil
        
        self.nameLabel.text = ""
        self.reviewLabel.text = ""
        self.starRatingView = nil
        self.reviewDateLabel = nil
    }
}

extension ReviewCell: Cell {
    
    typealias T = Review
    
    func configure(with value: Review) {
        nameLabel.text = value.authorName
        reviewLabel.numberOfLines = 0
        reviewLabel.text = value.text
        starRatingView.rating = Double(value.rating)
        reviewDateLabel.text = value.relativeTimeDescription
        
        let defaultImage = UIImage(named:"placeholder_image")
        
        guard let url = URL(string: value.profilePhotoURL) else { return }
        
        profileImage.af.setImage(withURL: url, placeholderImage: defaultImage)
    }
}
