//
//  SecondViewController.swift
//  LTC_Workshop
//
//  Created by Harish K on 11/2/16.
//  Modified by Monish V on 9/19/17.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class UpcomingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var newworkshopClass:WorkshopDetails!
    var newworkshop = [WorkshopDetails]()
    var selectedRow:Int!
    var descriptionArray:[String]!
    var workshopIDArray:[Int]!
    var workshopNameArray:[String]!
    var newMeeting = [MeetingDetails]()
    

    @IBOutlet weak var upcomingTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Upcoming"
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "006747")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.upcomingTV.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.upcomingTV.reloadData()
        }
        fetchUpcoming()
    }
    
    
    func fetchUpcoming() {
        self.newMeeting = []
        self.newworkshop = []
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")
        let AccessToken = defaults.string(forKey: "Access_Token")
        let url:String =  "\(Global.hostURL)upcoming?username=\(UserID!)&accessToken=\(AccessToken!)"
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                
                for index in 0..<json.count {
                    
                    for innerindex in 0..<json[index]["meetings"].count {
                        self.newMeeting.append(MeetingDetails(workshopID: json[index]["workshop"]["workshopID"].int!, meetingID: json[index]["meetings"][innerindex]["meetingID"].intValue, buildingID: json[index]["meetings"][innerindex]["buildingID"].stringValue, roomNumber: json[index]["meetings"][innerindex]["roomNumber"].intValue, meeting_start_time: json[index]["meetings"][innerindex]["meetingStart"].stringValue, meeting_end_time: json[index]["meetings"][innerindex]["meetingEnd"].stringValue, meeting_presenter: json[index]["meetings"][innerindex]["presenter"].stringValue,isEnrolled: json[index]["meetings"][innerindex]["isEnrolled"].boolValue,isAttended: json[index]["meetings"][innerindex]["isAttended"].boolValue))
                    }
                    
                    self.newworkshop.append(WorkshopDetails(workshopId: json[index]["workshop"]["workshopID"].int!, workshopDesc: json[index]["workshop"]["description"].string!, workshopName: json[index]["workshop"]["workshopName"].string!, meeting: newMeeting))
                }
             }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return newworkshop.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "upcoming_cell")
        let workshopName = cell?.contentView.viewWithTag(305) as! UILabel
        let workshop_image = cell?.contentView.viewWithTag(303) as! UIImageView
        workshop_image.image = UIImage(named:"icons8-Training-96.png")
        workshop_image.layer.borderWidth = 1.0
        workshop_image.layer.masksToBounds = true
        workshop_image.layer.borderColor = UIColor.clear.cgColor
        workshop_image.layer.cornerRadius = workshop_image.frame.size.height/2
        workshop_image.clipsToBounds = true
        workshop_image.contentMode = .scaleToFill
        
        workshopName.text = newworkshop[indexPath.row].workshopName
        cell?.backgroundColor = UIColor(red: 237/255, green: 242/255, blue: 240/225, alpha: 1.0)
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 5
        
        return cell!

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "upcoming_cell"
        {
        if let nextVC = segue.destination as? UpcomingDetailsViewController {
            nextVC.workshopClass = newworkshop[(self.upcomingTV.indexPathForSelectedRow?.row)!]
        }
    }
    }
    
    
    

}


