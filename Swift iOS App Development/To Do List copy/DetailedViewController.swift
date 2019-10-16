//
//  DetailedViewController.swift
//  To Do List
//
//  Created by Kyle Gil Tan on 9/21/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit

class DetailedViewController: UIViewController {

    
    @IBOutlet weak var toDoField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var toDoNoteView: UITextView!
    
    var toDoItem: String?
    var toDoNoteItem: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let toDoItem = toDoItem {
            toDoField.text = toDoItem
            self.navigationItem.title = "Edit To Do Item"
        }
        else{
            self.navigationItem.title = "New To Do Item"
        }
        if let toDoNoteItem = toDoNoteItem{
            toDoNoteView.text = toDoNoteItem
        }
        enableDisableSaveButton()
        toDoField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    func enableDisableSaveButton(){
        if let toDoFieldCount = toDoField.text?.count, toDoFieldCount > 0 {
            saveBarButton.isEnabled = true
        }
        else{
            saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func toDoFieldChanged(_ sender: UITextField) {
//        if toDoField.text!.count > 0{
//            saveBarButton.isEnabled = true
//        }
//        else{
//            saveBarButton.isEnabled = false
//        }
        enableDisableSaveButton()
    }
    
    @IBAction func cancelledPressed(_ sender: UIBarButtonItem) {
        let isPresentinginAddMode = presentingViewController is UINavigationController
        if isPresentinginAddMode{
            dismiss(animated: true, completion: nil)
        }
        else{
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromSave"{
            toDoItem = toDoField.text
            toDoNoteItem = toDoNoteView.text
        }
    }


}
