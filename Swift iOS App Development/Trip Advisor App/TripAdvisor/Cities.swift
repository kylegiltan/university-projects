//
//  Cities.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation
import Firebase

class Cities{
    var cityArray = [City]()
    var db: Firestore!
    
    init(){
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()){
        db.collection("cities").addSnapshotListener{ (querySnapshot, error) in
            guard error == nil else{
                print("error adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.cityArray = []
            //there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents{
                let city = City(dictionary: document.data())
                city.documentID = document.documentID
                self.cityArray.append(city)
            }
            completed()
        }
    }
}
