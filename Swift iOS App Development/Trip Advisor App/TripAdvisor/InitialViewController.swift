//
//  InitialViewController.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    

    @IBAction func homeScreenPressed(_ sender: Any) {
        performSegue(withIdentifier: "Start", sender: nil)
    }
    

}
