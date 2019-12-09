//
//  AttractionsTableTableViewController.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/8/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit

class AttractionsTableTableViewController: UITableViewController {

    @IBOutlet weak var nameField: UITextView!
    @IBOutlet weak var typeField: UITextView!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addMediaButton: UIButton!

    
    var city: City!
    var event: Event!
    var photos: Photos!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        addMediaButton.isHidden = false
        deleteButton.isHidden = false
        cancelBarButton.title = ""
        cancelBarButton.isEnabled = false
        
        //hide keyboard if we tap outside field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        guard let city = city else{
            print("no valid city")
            return
        }
        self.navigationItem.title = city.name
//        if event == nil{
//            event = Event()
//        }
//        nameField.text = event.name
//        typeField.text = event.type
//        reviewTextView.text = event.details
        
        photos = Photos()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if event != nil{
        photos.loadData(city: city, event: event) {
            self.collectionView.reloadData()
            }
        nameField.text = event.name
        typeField.text = event.type
        reviewTextView.text = event.details
        }
    }
    
    func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func leaveViewController(){
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            
            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    func cameraOrLibraryAlert(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){ _ in
            self.accessCamera()
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.accessLibrary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addMediaButtonPressed(_ sender: UIButton) {
        if event == nil{
            showAlert(title: "Error", message: "Please save event before adding media.")
        }
        else{
            saveBarButton.title = ""
            cameraOrLibraryAlert()
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if event == nil{
            event = Event()
        }
        event.city = city.name
        event.name = nameField.text!
        event.type = typeField.text!
        event.details = reviewTextView.text!
        event.saveData(city: city) { (success) in
            if success{
                self.leaveViewController()
            }
            else{
                print("error data was never saved")
            }
        }
        //        saveThenSegue()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        //        review.deleteDate(spot: spot) { (success) in
        //            if success{
        //                self.leaveViewController()
        //            }
        //            else{
        //                print("ERROR DELETE UNSUCCESSFUL")
        //            }
        //        }
    }
    

    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AttractionsTableTableViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.photoArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! EventsPhotosCollectionViewCell
        cell.photo = photos.photoArray[indexPath.row]
        return cell
    }
}

extension AttractionsTableTableViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = Photo()
        photo.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //photos.photoArray.append(photo)
        dismiss(animated: true) {
            photo.saveData(city: self.city, event: self.event, completed: { (success) in
//                                if success{
//                                    self.photos.photoArray.append(photo)
//                                    self.collectionView.reloadData()
//                
//                                }
            })
            //self.collectionView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func accessLibrary(){
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    func accessCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        }
        else{
            showAlert(title: "Camera Not Available", message: "There is no camera available on device.")
        }
    }
}
