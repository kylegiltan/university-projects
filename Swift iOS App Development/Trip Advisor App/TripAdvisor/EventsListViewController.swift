//
//  EventsListViewController.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit
import GooglePlaces
import MapKit

class EventsListViewController: UIViewController {
    
    @IBOutlet weak var tableViewTableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var city: City!
    var events: Events!

    let regionDistance: CLLocationDistance = 1000000 //meters
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBarButton.isEnabled = false
        
        tableViewTableView.delegate = self
        tableViewTableView.dataSource = self
        //mapView.delegate = self
        
        
        
        if city == nil{
            city = City()
        }
        self.navigationItem.title = city.name
        events = Events()
        
        let region = MKCoordinateRegion(center: city.coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
        updateUserInterface()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        events.loadData(city: city) {
            self.tableViewTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        city.name = self.navigationItem.title!
        switch segue.identifier ?? ""{
        case "AddReview":
            let navigationController = segue.destination as! UINavigationController
            let destination = navigationController.viewControllers.first as! AttractionsTableTableViewController
            destination.city = city
            if let selectedIndexPath = tableViewTableView.indexPathForSelectedRow{
                tableViewTableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        case "ShowReview":
            let destination = segue.destination as! AttractionsTableTableViewController
            destination.city = city
            let selectedIndexPath = tableViewTableView.indexPathForSelectedRow!
            destination.event = events.eventArray[selectedIndexPath.row]
        default:
            print("No segue in SpotDetailViewController")
        }
    }
    
    
    
    func updateUserInterface(){
        tableViewTableView.isHidden = false
        mapView.isHidden = false
        //addToFavorites.isHidden = false
        self.navigationItem.title = city.name
        updateMap()
    }
    
    func updateMap(){
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(city)
        mapView.setCenter(city.coordinate, animated: true)
    }
    
    @IBAction func addReviewButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "AddReview", sender: nil)
    }
    
    
}

extension EventsListViewController: UITableViewDelegate, UITableViewDataSource{
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
