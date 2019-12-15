//
//  Categories.swift
//  JeopardyTrainer
//
//  Created by Kyle Gil Tan on 12/8/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Categories{
    var apiURL = "http://jservice.io/api/categories/"
    var categoryCount = 5
    var categoryArray: [Category] = []
    
    func getData(completed: @escaping() -> ()){
        let apiURLnew = "\(apiURL)/?count=\(categoryCount)"
        Alamofire.request(apiURLnew).responseJSON {(response) in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
                //print("JSON \(json)")
                let numberOfCategories = json.count
                for index in 0..<numberOfCategories{
                    let id = json[index]["id"].intValue
                    let title = json[index]["title"].stringValue
                    let clues_count = json[index]["clues_count"].intValue
                    self.categoryArray.append(Category(id: id, title: title, cluesCount: clues_count))
                }
            case.failure(let error):
                print("Error getting data from url")
            }
            completed()
        }
        
    }
    
}
