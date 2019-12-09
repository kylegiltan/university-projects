//
//  Event.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase

class Event{
    var city: String
    var name: String
    var type: String
    var details: String
    var postingUserID: String
    var documentID: String

    var dictionary: [String: Any]{
        return ["city": city, "name": name, "type": type, "details": details, "postingUserID": postingUserID]
    }
    
    init(city: String, name: String, type: String, details: String, postingUserID: String, documentID: String) {
        self.city = city
        self.name = name
        self.type = type
        self.details = details
        self.postingUserID = postingUserID
        self.documentID = documentID
    }
    
    convenience init(dictionary: [String: Any]){
        let city = dictionary["city"] as! String? ?? ""
        let name = dictionary["name"] as! String? ?? ""
        let type = dictionary["type"] as! String? ?? ""
        let details = dictionary["details"] as! String? ?? ""
        let postingUserID = dictionary["postingUserID"] as! String? ?? ""
        self.init(city: city, name: name, type: type, details: details, postingUserID: postingUserID, documentID: "")
    }
    
    convenience init() {
        let currentUser = Auth.auth().currentUser?.email ?? "Unknown User"
        self.init(city: "", name: "", type: "", details: "", postingUserID: currentUser, documentID: "")
    }
    

    func saveData(city: City, completed: @escaping (Bool) -> ()){
        let db = Firestore.firestore()
        //Grab userID
//        guard let postingUserID = (Auth.auth().currentUser?.uid) else{
//            print("couldn't save data bc we don't have a valid posting ID")
//            return completed(false)
//        }
//        self.postingUserID = postingUserID
        //create dictionary representing the data we want to save
        let dataToSave = self.dictionary
        //if we have saved a rec, we'll have a docID
        if self.documentID != ""{
            let ref = db.collection("cities").document(city.documentID).collection("events").document(self.documentID)
            //or is self.documentID in quotes?
            ref.setData(dataToSave){(error) in
                if let error = error{
                    print("error updateding doc \(self.documentID) in city \(city.documentID) error \(error.localizedDescription)")
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
            ref = db.collection("cities").document(city.documentID).collection("events").addDocument(data: dataToSave){error in
                if let error = error{
                    print("error updateding doc \(self.documentID) in city \(city.documentID) error \(error.localizedDescription) for new doc id")
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
