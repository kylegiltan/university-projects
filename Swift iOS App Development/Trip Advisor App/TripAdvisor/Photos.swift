//
//  Photos.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/8/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation
import Firebase

class Photos{
    var photoArray: [Photo] = []
    var db: Firestore
    
    init(){
        db = Firestore.firestore()
    }
    
    func loadData(city: City, event: Event, completed: @escaping () -> ()){
        guard city.documentID != "" else{
            return
        }
        let storage = Storage.storage()
        db.collection("cities").document(city.documentID).collection("events").document(event.documentID).collection("photos").addSnapshotListener{ (querySnapshot, error) in
            guard error == nil else{
                print("error adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.photoArray = []
            var loadAttempts = 0
            let storageRef = storage.reference().child(city.documentID)
            //there are querySnapshot!.documents.count documents in the spots snapshot
            for document in querySnapshot!.documents{
                let photo = Photo(dictionary: document.data())
                photo.documentUUID = document.documentID
                self.photoArray.append(photo)
                //loading in firebase storage images
                let photoRef = storageRef.child(photo.documentUUID)
                photoRef.getData(maxSize: 25 * 1025 * 1025){ data, error in
                    if let error = error {
                        print("AN ERROR OCCURED WHILE READING DATA FROM FILE REF: \(photoRef) \(error.localizedDescription)")
                        loadAttempts += 1
                        if loadAttempts >= (querySnapshot!.count){
                            return completed()
                        }
                    }
                    else{
                        let image = UIImage(data: data!)
                        photo.image = image!
                        loadAttempts += 1
                        if loadAttempts >= (querySnapshot!.count){
                            return completed()
                        }
                    }
                }
            }
        }
    }
}
