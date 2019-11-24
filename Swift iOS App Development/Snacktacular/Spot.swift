//
//  Spot.swift
//  Snacktacular
//
//  Created by Kyle Gil Tan on 11/1/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import MapKit

class Spot: NSObject, MKAnnotation{
    var name: String
    var address: String
    var coordinate: CLLocationCoordinate2D
    var averageRating: Double
    var numberOfReviews: Int
    var postingUserID: String
    var documentID: String
    
    var longitude: CLLocationDegrees{
        return coordinate.longitude
    }
    var latitude: CLLocationDegrees{
        return coordinate.latitude
    }
    
    var location: CLLocation{
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    var title: String?{
        return name
    }
    
    var subtitle: String?{
        return address
    }
    
    var dictionary: [String: Any]{
        return ["name": name, "address": address, "longitude": longitude, "latitude": latitude, "averageRating": averageRating, "numberOfReviews": numberOfReviews, "postingUserID": postingUserID]
    }
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D, averageRating: Double, numberOfReviews: Int, postingUserID: String, documentID: String) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.averageRating = averageRating
        self.numberOfReviews = numberOfReviews
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    convenience override init() {
        self.init(name: "", address: "", coordinate: CLLocationCoordinate2D(), averageRating: 0.0, numberOfReviews: 0, postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]){
        let name = dictionary["name"] as! String? ?? ""
        let address = dictionary["address"] as! String? ?? ""
        let latitude = dictionary["latitude"] as! CLLocationDegrees? ?? 0.0
        let longitude = dictionary["longitude"] as! CLLocationDegrees? ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let averageRating = dictionary["averageRating"] as! Double? ?? 0.0
        let numberOfReviews = dictionary["numberOfReviews"] as! Int? ?? 0
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(name: name, address: address, coordinate: coordinate, averageRating: averageRating, numberOfReviews: numberOfReviews, postingUserID: postingUserID, documentID: "")
    }
    
    func saveData(completed: @escaping (Bool) -> ()){
        let db = Firestore.firestore()
        //Grab userID
        guard let postingUserID = (Auth.auth().currentUser?.uid) else{
            print("couldn't save data bc we don't have a valid posting ID")
            return completed(false)
        }
        self.postingUserID = postingUserID
        //create dictionary representing the data we want to save
        let dataToSave = self.dictionary
        //if we have saved a rec, we'll have a docID
        if self.documentID != ""{
            
            
            let ref = db.collection("spots").document(self.documentID)
            //or is self.documentID in quotes?
            
            
            ref.setData(dataToSave){(error) in
                if let error = error{
                    print("error updateding doc \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else{
                    print("document updated with ref DI \(ref.documentID)")
                    completed(true)
                }
            }
        }
        else{
            var ref: DocumentReference? = nil
            ref = db.collection("spots").addDocument(data: dataToSave){error in
                if let error = error{
                    print("error creating doc \(self.documentID) \(error.localizedDescription)")
                    completed(false)
                }
                else{
                    print("document created with ref DI \(ref?.documentID ?? "unknown")")
                    self.documentID = ref!.documentID
                    completed(true)
                }
            }
        }
    }
    
    func updateAverageRating(completed: @escaping () -> ()){
        let db = Firestore.firestore()
        let reviewRef = db.collection("spots").document(self.documentID).collection("reviews")
        reviewRef.getDocuments{ (querySnapshot, error) in
            guard error == nil else{
                print("ERROR FAILED TO GET QUERY SNAPSHOT OF REVIEW FOR REVIEWSREF: \(reviewRef.path), ERROR \(error!.localizedDescription)")
                return completed()
            }
            var ratingTotal = 0.0
            for document in querySnapshot!.documents{ //go throught all of the reviews documents
                let reviewDictionary = document.data()
                let rating = reviewDictionary["rating"] as! Int? ?? 0
                ratingTotal = ratingTotal + Double(rating)
            }
            self.averageRating = ratingTotal / Double(querySnapshot!.count)
            self.numberOfReviews = querySnapshot!.count
            let dataToSave = self.dictionary
            let spotRef = db.collection("spots").document(self.documentID)
            spotRef.setData(dataToSave){ error in  // save it and check errors
                guard error == nil else{
                    print("ERROR UPDATING DOCUMENT\(self.documentID) IN SPOT AFTER CHANGING AVERAGE REVIEW AND NUMBER OF REVIEWS, ERROR: \(error!.localizedDescription)")
                    return completed()
                }
                print("document updated w ref id \(self.documentID)")
                completed()
            }
        }
    }
    
}
