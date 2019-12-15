//
//  Category.swift
//  JeopardyTrainer
//
//  Created by Kyle Gil Tan on 12/8/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import Foundation

class Category{
    var id: Int
    var title: String
    var cluesCount: Int
    
    init(id: Int, title: String, cluesCount: Int){
        self.id = id
        self.title = title
        self.cluesCount = cluesCount
    }
}
