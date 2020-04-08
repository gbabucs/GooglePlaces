//
//  ViewController.swift
//  GooglePlaces
//
//  Created by ThunderFlash on 04/04/2020.
//  Copyright © 2020 system. All rights reserved.
//

import UIKit
import CoreLocation
import RSSelectionMenu
import JGProgressHUD

protocol FilterDelegate: class {
    func apply(_ types: Dictionary<String, String>)
}

class PlacesViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortBarButton: UIButton!
    
    //--------------------------------------------------------------------------
    // MARK: - Properties
    //--------------------------------------------------------------------------
    let locationManager = CLLocationManager()
    let hud = JGProgressHUD(style: .dark)
    
    var location: CLLocation?
    var lastLocationError: Error?
    var updatingLocation = false
    var filterDict = Dictionary<String, String>()
    var defaultRadius = "2.0"
    var defaultSearchType = "restaurant"
    var viewModel = PlacesViewModel()
    var selectedSortType = [String]()
    
    
    
    private(set) var selectedPlace: PlacesResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getLocation()
    }
    
    func setupView() {
        self.title = "Search Places"
        //Default values
        filterDict["type"] = defaultSearchType
        hud.textLabel.text = "Loading"
        tableView.tableFooterView = UIView()
    }
    
    func getLocation(){
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        updatingLocation = true
    }
    
    func showLocationServicesDeniedAlert() {
        var alertTitle = "Location Services Disabled"
        var alertMessage = "Please enable location services for this app in Settings."
        
        if lastLocationError != nil {
            alertTitle = "Error"
            alertMessage = "Unable to fetch current location."
        }
        
        showAlert(with: alertTitle, detail: alertMessage)
    }
    
    func stopLocationManager() {
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
    
        let simpleDataArray = [Sorting.ascending.displayName,
                               Sorting.descending.displayName,
                               Sorting.open.displayName,
                               Sorting.closed.displayName,
                               Sorting.distance.displayName]
        
        let selectionMenu = RSSelectionMenu(dataSource: simpleDataArray) { (cell, item, indexPath) in
            cell.textLabel?.text = item
        }

        selectionMenu.setSelectedItems(items: selectedSortType) { [weak self] (item, index, isSelected, selectedItems) in
            self?.selectedSortType = selectedItems
        }
        
        selectionMenu.show(style: .popover(sourceView: sortBarButton, size: CGSize(width: 180, height: 190)), from: self)
        
        selectionMenu.onDismiss = { [weak self] selectedItems in
            guard let type = selectedItems.first?.lowercased() else { return }
            
            self?.viewModel.sortBy(type: type)
            self?.tableView.reloadData()
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == UIStoryboardSegue.showFilterIdentifier {
            guard let filterViewController = segue.destination as? FilterViewController
                else { return }
            
            filterViewController.filterDelegate = self
            
            //Send default value to FilterViewController
            filterViewController.filterDict = filterDict
            
        } else if segue.identifier == UIStoryboardSegue.showDetailIdentifier {
            guard let placeDetailViewController = segue.destination as? PlaceDetailViewController,
                let indexPath = sender as? IndexPath
                else { return }
            
            placeDetailViewController.place = viewModel.places[indexPath.row]
            
        }
    }
}

extension PlacesViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        
        lastLocationError = error
        stopLocationManager()
        showLocationServicesDeniedAlert()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        
        location = newLocation
        stopLocationManager()
    }
}

extension PlacesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.viewModel.places.count > 0 {
            performSegue(withIdentifier: UIStoryboardSegue.showDetailIdentifier, sender: indexPath)
        }
    }
}

extension PlacesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlacesResultCell.reuseIdentifier) as? PlacesResultCell
            else { return UITableViewCell() }
        
        let place = self.viewModel.places[indexPath.row]
        
        cell.configure(with: place)
        
        return cell
    }
}

extension PlacesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let location = location else { return showLocationServicesDeniedAlert() }
        
        let escapedSearchText = searchBar.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let radius = defaultRadius
        let types = filterDict["type"] ?? defaultSearchType
        
        self.viewModel = PlacesViewModel(searchText: escapedSearchText, latitude: latitude, longitude: longitude, radius: radius, types: types)
        
        
        if NetworkState.isConnected {
            hud.show(in: self.view)
            self.viewModel.getPlaces { isError in
                DispatchQueue.main.async {
                    self.hud.dismiss()
                    if isError {
                        self.showAlert(with: "Server problem", detail: "Please try again later")
                    }
                    
                    self.tableView.reloadData()
                }
            }
        } else {
            self.showAlert(with: "", detail: "Please check your Internet connection")
        }
    }
}

extension PlacesViewController: FilterDelegate {
    func apply(_ types: Dictionary<String, String>) {
        filterDict = types
    }
}
