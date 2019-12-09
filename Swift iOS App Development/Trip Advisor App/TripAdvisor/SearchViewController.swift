//
//  SearchViewController.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit
import CoreLocation
import GooglePlaces
import  MapKit



class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToFavorites: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var magnifyingGlass: UIImageView!
    

    var city: City!
    var events: Events!
    
    let regionDistance: CLLocationDistance = 1000000 //meters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        mapView.isHidden = true
        addToFavorites.isHidden = true
        addBarButton.isEnabled = false
        magnifyingGlass.image = UIImage(named: "magnifyingGlass")
        
        tableView.delegate = self
        tableView.dataSource = self
        //mapView.delegate = self
        
        if city == nil{
            city = City()
            
        }
        
        events = Events()
        let region = MKCoordinateRegion(center: city.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
        //updateUserInterface()
    }
    
    func updateUserInterface(){
        tableView.isHidden = false
        mapView.isHidden = false
        addToFavorites.isHidden = false
        self.navigationItem.title = city.name
        updateMap()
        //addBarButton.isEnabled = true
        magnifyingGlass.image = nil
    }

    func updateMap(){
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(city)
        mapView.setCenter(city.coordinate, animated: true)
    }
    
//    func leaveViewController(){
//        let isPresentingInAddMode = presentingViewController is UINavigationController
//        if isPresentingInAddMode {
//            dismiss(animated: true, completion: nil)
//        } else {
//            navigationController?.popViewController(animated: true)
//        }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        events.loadData(city: city) {
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        city.name = self.navigationItem.title!
        switch segue.identifier ?? ""{
        case "AddReviewTwo":
//            let navigationController = segue.destination as! UINavigationController
//            let destination = navigationController.viewControllers.first as! AttractionsTableViewControllerTwo
//            destination.city = city
//            if let selectedIndexPath = tableView.indexPathForSelectedRow{
//                tableView.deselectRow(at: selectedIndexPath, animated: true)
            print("hey")
            
            
            //alert that says please add to favorites first
            
        case "ShowReviewTwo":
            let destination = segue.destination as! AttractionsTableTableViewController
            destination.city = city
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            //            destination.review = reviews.reviewArray[selectedIndexPath.row]
            destination.event = events.eventArray[selectedIndexPath.row]
        default:
            print("No segue in SpotDetailViewController")
        }
    }
    
    @IBAction func addReviewButtonPressed(_ sender: UIButton) {
        showAlert(title: "Error", message: "Please add to favorites")
    }
    
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func searchCityPressed(_ sender: UIBarButtonItem) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        updateUserInterface()
    }
    
    @IBAction func addToFavoritesPressed(_ sender: Any) {
        city.saveData{ success in
            if success{
                self.showAlert(title: "Success", message: "Added to favorites")
            }
            else{
                print("ERROR COULDN'T LEAVE THIS VIEW CONTROLLED BC DATA WASN'T SAVED")
            }
        }
    }
    

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ShowAttractionTwo" {
//            let destination = segue.destination as! AttractionsViewControllerTwo
//
//
//            /*
//
//
//             remove navigation controller
//
//
//             */
//
//
//
//
//            let selectedIndexPath = tableView.indexPathForSelectedRow!
//            destination.event = events.eventArray[selectedIndexPath.row]
//        }
//        else{
//            if let selectedIndexPath = tableView.indexPathForSelectedRow{
//                tableView.deselectRow(at: selectedIndexPath, animated: true)
//            }
//        }
//    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.eventArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        /*
         maybe in future make new class for table view cell, have it so that you can have the flag of the country. see 9.2 19:18
         */
        cell.textLabel?.text = events.eventArray[indexPath.row].name
        return cell
    }


}

extension SearchViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        city.name = place.name!
        city.coordinate = place.coordinate
        //event.city = city.name
        dismiss(animated: true, completion: nil)
        updateUserInterface()
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

