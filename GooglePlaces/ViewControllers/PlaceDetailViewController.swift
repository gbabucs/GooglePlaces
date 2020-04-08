//
//  PlaceDetailViewController.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit
import Cosmos
import ImageSlideshow
import Alamofire
import AlamofireImage
import JGProgressHUD

class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak var imageSlideShow: ImageSlideshow!
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var awayLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var openNowLabel: UILabel!
    
    let hud = JGProgressHUD(style: .dark)
    
    var place: PlacesResult?
    var viewModel: PlacesDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Place Detail"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getPlaceDetail()
    }
    
    func getPlaceDetail() {
        guard let place = place else { return }
        
        viewModel = PlacesDetailViewModel(place: place)
        
        if NetworkState.isConnected {
            hud.show(in: self.view)
            viewModel?.getPlaceDetail() { isError in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                    if isError {
                        self.showAlert(with: "Server Problem", detail: "Please try again later.")
                    } else {
                        self.setupView()
                        self.reviewTableView.reloadData()
                        
                        guard let viewModel = self.viewModel else { return }
                        self.imageSlideShow.setImageInputs(viewModel.loadPlaceImages())
                    }
                }
            }
        } else {
            self.showAlert(with: "", detail: "Please check your Internet connection")
        }
    }
    
    func setupView() {
        reviewTableView.estimatedRowHeight = 140
        reviewTableView.rowHeight = UITableView.automaticDimension
        
        ratingView.settings.fillMode = .precise
        ratingView.settings.updateOnTouch = false
        
        if let place = viewModel?.place {
            self.navigationItem.title = place.name
            self.addressLabel.text = place.vicinity
            self.ratingView.rating = place.rating
            self.openNowLabel.changeLabelColor(place.openingHours.openNow)
        }
        
        imageSlideShow.backgroundColor = .white
        imageSlideShow.slideshowInterval = 5.0
        
        imageSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .left(padding: 20), vertical: .bottom)
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = .lightGray
        pageIndicator.pageIndicatorTintColor = .gray
        
        imageSlideShow.pageIndicator = pageIndicator
        imageSlideShow.contentScaleMode = .scaleAspectFill
    
        reviewTableView.tableFooterView = UIView()
    }
}

extension PlaceDetailViewController: UITableViewDelegate {}

extension PlaceDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.reviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.reuseIdentifier) as? ReviewCell,
            let viewModel = self.viewModel
            else { return UITableViewCell() }
        
        let review = viewModel.reviews[indexPath.row]
        
        cell.configure(with: review)
        
        return cell
    }
}

