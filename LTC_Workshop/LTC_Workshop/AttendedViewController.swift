//
//  AttendedViewController.swift
//  LTC_Workshop
//
//  Created by Harish K on 11/7/16.
//  Modified by Monish V on 9/19/17.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class AttendedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //declaring the variables
    var newworkshopClass:WorkshopDetails!
    var newworkshop = [WorkshopDetails]()
    var selectedRow:Int!
    var descriptionArray:[String]!
    var workshopIDArray:[Int]!
    var workshopNameArray:[String]!
    var newMeeting = [MeetingDetails]()

    //MARK: OUTLETS
    @IBOutlet weak var attendedTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adding a title and color to the navigation bar
        self.navigationItem.title = "My Attended Workshops"
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "006747")
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.attendedTV.separatorColor = UIColor.clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")
        let AccessToken = defaults.string(forKey: "Access_Token")
        let url:String =  "\(Global.hostURL)attended?username=\(UserID!)&accessToken=\(AccessToken!)"
        fetchSchedule(url: url)
    }
    
    //fetching attended workshops from the call
    func fetchSchedule(url:String) {
        self.newMeeting = []
        self.newworkshop = []
        
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                if json.count > 0 {
                    //Looping through json response and storing array
                    for index in 0...json.count-1 {
                        for innerindex in 0...json[index]["meetings"].count-1 {
                            self.newMeeting.append(MeetingDetails(workshopID: json[index]["workshop"]["workshopID"].int!, meetingID: json[index]["meetings"][innerindex]["meetingID"].intValue, buildingID: json[index]["meetings"][innerindex]["buildingID"].stringValue, roomNumber: json[index]["meetings"][innerindex]["roomNumber"].intValue, meeting_start_time: json[index]["meetings"][innerindex]["meetingStart"].stringValue, meeting_end_time: json[index]["meetings"][innerindex]["meetingEnd"].stringValue, meeting_presenter: json[index]["meetings"][innerindex]["presenter"].stringValue,isEnrolled: json[index]["meetings"][innerindex]["isEnrolled"].boolValue,isAttended: json[index]["meetings"][innerindex]["isAttended"].boolValue))
                        }
                        
                        self.newworkshop.append(WorkshopDetails(workshopId: json[index]["workshop"]["workshopID"].int!, workshopDesc: json[index]["workshop"]["description"].string!, workshopName: json[index]["workshop"]["workshopName"].string!, meeting: newMeeting))
                    }
                    
                    self.attendedTV.reloadData()
                    
                }
                else {
                    self.attendedTV.reloadData()
                }
                
                
            }
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newworkshop.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //building custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "attended_cell")
        let workshopName = cell?.contentView.viewWithTag(500) as! UILabel
        let attendedDate = cell?.contentView.viewWithTag(501) as! UILabel
        let attendedLocation = cell?.contentView.viewWithTag(502) as! UILabel
        let workshop_image = cell?.contentView.viewWithTag(503) as! UIImageView
        workshop_image.image = UIImage(named:"icons8-Training-96.png")
        workshop_image.clipsToBounds = true
        workshop_image.contentMode = .scaleToFill
        
        workshopName.text = newworkshop[indexPath.row].workshopName
        attendedDate.text = timeConversion(newMeeting[indexPath.row].meeting_start_time!)
        attendedLocation.text = "\(newMeeting[indexPath.row].buildingID!) \(newMeeting[indexPath.row].roomNumber!)"

        cell?.backgroundColor = UIColor(red: 237/255, green: 242/255, blue: 240/225, alpha: 1.0)
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 1.0
        cell?.layer.cornerRadius = 5
        return cell!
    }
    
    // MARK: - Navigation

    // parsing selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
    }
    
    // sending the data to FeedbackViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "feedback" {
            if let nextVC = segue.destination as? FeedbackViewController {
                nextVC.newworkshopClass = newworkshop[(self.attendedTV.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
//    Unwinding segue
    @IBAction func unwindfromSecondView(_ sender: UIStoryboardSegue) {
    }
    
    //Converting time from string to proper format 
    func timeConversion(_ dateString:String) -> String{
        let string = dateString
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm a"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        return dateString
    }


}

