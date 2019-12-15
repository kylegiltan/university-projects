//
//  Clues.swift
//  JeopardyTrainer
//
//  Created by Kyle Gil Tan on 12/8/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Clues{
    var id = 0
    var clueCount = 5
    var apiURL = "http://jservice.io/api/category/?id="
    var clueArray: [Clue] = []
    
    func getData(completed: @escaping() -> ()){
        Alamofire.request(apiURL+"\(id)").responseJSON {(response) in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
                let numberOfClues = json["clues"].count
                //print("JSON \(json)")
                for index in 0..<numberOfClues{
                    let clue = Clue()
                    clue.question = json["clues"][index]["question"].stringValue
                    clue.answer = json["clues"][index]["answer"].stringValue
                    clue.categoryID = json["clues"][index]["category_id"].intValue
                    clue.value = json["clues"][index]["value"].intValue
                    clue.clueID = json["clues"][index]["id"].intValue
                    self.clueArray.append(clue)
                    
                }
            case.failure(let error):
                print("Error getting data from url")
            }
            completed()
        }
        
    }
    
}
