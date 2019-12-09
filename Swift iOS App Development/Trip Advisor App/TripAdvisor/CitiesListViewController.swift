//
//  CitiesListViewController.swift
//  TripAdvisor
//
//  Created by Kyle Gil Tan on 12/4/19.
//  Copyright © 2019 Kyle Gil Tan. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseUI
import GoogleSignIn

class CitiesListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    
    var cities: Cities!
    var authUI: FUIAuth!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBarButton.title = ""
        addBarButton.isEnabled = false
        authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true

        cities = Cities()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        signIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cities.loadData {
            self.tableView.reloadData()
        }
    }
    
    func signIn(){
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
        ]
        if authUI.auth?.currentUser == nil{
            self.authUI.providers = providers
            present(authUI.authViewController(), animated: true, completion: nil)
        }
        else{
            tableView.isHidden = false
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowCity"{
            let destination = segue.destination as! EventsListViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.city = cities.cityArray[selectedIndexPath.row]
        }
        else{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
    
    @IBAction func signOutPressed(_ sender: Any) {
        do{
            try authUI!.signOut()
            print("SIGN OUT SUCCESSFUL")
            tableView.isHidden = true
            signIn()
        }
        catch{
            tableView.isHidden = true
            print("ERROR COULDN'T SIGN OUT")
        }
    }
    
    
}

extension CitiesListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.cityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        /*
         maybe in future make new class for table view cell, have it so that you can have the flag of the country. see 9.2 19:18
         */
        cell.textLabel?.text = cities.cityArray[indexPath.row].name
        return cell
    }
    
    
}

extension CitiesListViewController: FUIAuthDelegate{
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        // other URL handling goes here.
        return false
    }
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        // handle user and error as necessary
        if let user = user{
            tableView.isHidden = false
            print("*** We signed in with the user \(user.email ?? "unknown email")")
        }
    }
    func authPickerViewController(forAuthUI authUI: FUIAuth) -> FUIAuthPickerViewController {
        let loginViewController = FUIAuthPickerViewController(authUI: authUI)
        loginViewController.view.backgroundColor = UIColor.white
        let marginInsets: CGFloat = 16
        let imageHeight: CGFloat = 225
        let imageY = self.view.center.y - imageHeight
        let logoFrame = CGRect(x: self.view.frame.origin.x + marginInsets, y: imageY, width: self.view.frame.width - (marginInsets*2), height: imageHeight)
        let logoImageView = UIImageView(frame: logoFrame)
        logoImageView.image = UIImage(named: "logo")
        logoImageView.contentMode = .scaleAspectFit
        loginViewController.view.addSubview(logoImageView)
        return loginViewController
    }
}
