//
//  MoreViewController.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/9/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {
    
    var selectedRow:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "More Options"
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "006747")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tableView.separatorColor = UIColor.clear

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreViewCell", for: indexPath)
        let textLabel = cell.contentView.viewWithTag(602) as! UILabel
        let imageView = cell.contentView.viewWithTag(601) as! UIImageView
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        
        cell.backgroundColor = UIColor(red: 237/255, green: 242/255, blue: 240/225, alpha: 1.0)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5

        switch indexPath.row {
        case 0:
            textLabel.text = "Leaderboard"
            imageView.image = #imageLiteral(resourceName: "leaderboard icon 1x")
            
        case 1:
            textLabel.text = "Contact"
            imageView.image = #imageLiteral(resourceName: "contact us icon 1x")
            
        case 2:
            textLabel.text = "Profile"
            imageView.image = #imageLiteral(resourceName: "user profile 1x")
            
        case 3:
            textLabel.text = "Request Workshop"
            imageView.image = #imageLiteral(resourceName: "presenter icon 1x")
        default:
            return cell
            
        }

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "leaderboard", sender: self)
        case 1:
            performSegue(withIdentifier: "profile", sender: self)
        case 2:
            performSegue(withIdentifier: "contactus", sender: self)
        case 3:
            performSegue(withIdentifier: "requestworkshop", sender: self)
        default: break
        }

    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
       
    }
    
}
