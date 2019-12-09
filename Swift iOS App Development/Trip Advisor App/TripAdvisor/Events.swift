//
//  Events.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation
import Firebase

class Events{
    var eventArray = [Event]()
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
    }
    
    func loadData(city: City, completed: @escaping () -> ()){
//        guard city.documentID != "" else{
//            return
//        }
        guard city.documentID != "" else{
            return
        }
        db.collection("cities").document(city.documentID).collection("events").addSnapshotListener{ (querySnapshot, error) in
            guard error == nil else{
                print("error adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.eventArray = []
            //there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents{
                print("idiot im in here")
                let event = Event(dictionary: document.data())
                event.documentID = document.documentID
                self.eventArray.append(event)
            }
            completed()
        }
    }
}
