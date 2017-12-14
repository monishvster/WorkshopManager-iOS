//
//  LeaderboardTableViewController.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/14/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class LeaderboardTableViewController: UITableViewController {
    
    var leaders:[String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Leaderboard"
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "006747")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.tableView.separatorColor = UIColor.clear
    }

    override func viewWillAppear(_ animated: Bool) {
        leaders = []
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")
        let AccessToken = defaults.string(forKey: "Access_Token")
        let url:String =  "\(Global.hostURL)leaderboard?username=\(UserID!)&accessToken=\(AccessToken!)"
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                for index in 0...json.count-1 {
                    leaders.append(json[index].string!)
                }
                
                
            }
        }
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
        return leaders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaders", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(leaders[indexPath.row])"

        return cell
    }
    


}
