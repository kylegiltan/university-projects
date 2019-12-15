//
//  QuestionsViewController.swift
//  JeopardyTrainer
//
//  Created by Kyle Gil Tan on 12/8/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    var clue: Clue!
    var categoryTitle: String!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var getItRightLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if clue == nil{
            questionLabel.text = "Error clue was nil"
        }
        if categoryTitle == nil{
            questionLabel.text = "Error category was nil"
        }
        categoryLabel.text = "Category: \(categoryTitle!)"
        questionLabel.text = clue.question
        answerLabel.text = clue.answer
        // Do any additional setup after loading the view.
    }
    


    @IBAction func showAnswerButtonPressed(_ sender: UIButton) {
        showAnswerButton.isHidden = true
        answerLabel.isHidden = false
        yesButton.isHidden = false
        noButton.isHidden = false
        getItRightLabel.isHidden = false
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func noButtonPressed(_ sender: Any) {
    }
    
}
