//
//  City.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase
import MapKit

class City: NSObject, MKAnnotation {
    var name: String
    var coordinate: CLLocationCoordinate2D
    var postingUserID: String
    var documentID: String
    
    var longitude: CLLocationDegrees{
        return coordinate.longitude
    }
    var latitude: CLLocationDegrees{
        return coordinate.latitude
    }
    var dictionary: [String: Any]{
        return ["name": name, "longitude": longitude, "latitude": latitude, "postingUserID": postingUserID]
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D, postingUserID: String, documentID: String) {
        self.name = name
        self.coordinate = coordinate
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience override init() {
        self.init(name: "", coordinate: CLLocationCoordinate2D(), postingUserID: "", documentID: "")
    }
    
    convenience init(dictionary: [String: Any]){
        let name = dictionary["name"] as! String? ?? ""
        let latitude = dictionary["latitude"] as! CLLocationDegrees? ?? 0.0
        let longitude = dictionary["longitude"] as! CLLocationDegrees? ?? 0.0
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(name: name, coordinate: coordinate, postingUserID: postingUserID, documentID: "")
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
            
            
            let ref = db.collection("cities").document(self.documentID)
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
            ref = db.collection("cities").addDocument(data: dataToSave){error in
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
    
    
}
