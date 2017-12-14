//
//  ScheduleDetailsViewController.swift
//  LTC_Workshop
//
//  Created by Harish K on 11/15/16.
//  Modified by Monish V on 9/19/17.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class ScheduleDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    //defining the variables
    var selectedMeeting:Int!
    var workshopClass:WorkshopDetails!
    var meeting:MeetingDetails!
    var meetings:[MeetingDetails] = []
    
    //MARK: OUTLETS
    @IBOutlet weak var meetingIV: UIImageView!
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var meetingTBV: UITableView!
    @IBOutlet weak var workshopnameLBL: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setting the title and color of navigation bar
        self.navigationItem.title = workshopClass.workshopName
        descriptionLBL.text = workshopClass.workshopDesc
        workshopnameLBL.text = workshopClass.workshopName
        
        //populating the meetings array
        for index in 0...workshopClass.meeting.count-1 {
            if workshopClass.workshopId == workshopClass.meeting[index].workshopID {
                meetings.append(workshopClass.meeting[index])
            }
        }
        self.meetingTBV.separatorColor = UIColor.clear
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //action for unregister button
    @objc func unregister(sender: Any){
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")
        let AccessToken = defaults.string(forKey: "Access_Token")
        //executing the api call to unregister from workshop
        let url:String = "\(Global.hostURL)registermeeting?username=\(UserID!)&accessToken=\(AccessToken!)&meetingId=\(meeting.meetingID!)&isRegistered=\(String(meeting.isEnrolled))"
        print("url here \(url)")
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                _ = JSON(data: data)
                
                //Going to root view controller after unregistering
                self.navigationController?.popToRootViewController(animated: true)
               
            }
        }
        

    }
    
    //Setting title for table
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Meetings"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //building custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "meeting_cell")
        let meeting_time = cell?.contentView.viewWithTag(200) as! UILabel
        let meeting_image = cell?.contentView.viewWithTag(300) as! UIImageView
        let meeting_endtime = cell?.contentView.viewWithTag(202) as! UILabel
        let meeting_location = cell?.contentView.viewWithTag(203) as! UILabel
        let presenter = cell?.contentView.viewWithTag(204) as! UILabel
        let unregisterbutton = cell?.contentView.viewWithTag(205) as! UIButton
        meeting_image.image = UIImage(named:"icons8-Clock-96.png")
        meeting_image.layer.borderWidth = 1.0
        meeting_image.layer.masksToBounds = false
        meeting_image.layer.borderColor = UIColor.clear.cgColor
        meeting_image.layer.cornerRadius = meeting_image.frame.size.height/2
        meeting_image.clipsToBounds = true
        meeting_time.text = timeConversion(meetings[indexPath.row].meeting_start_time!)
        meeting_endtime.text = timeConversion(meetings[indexPath.row].meeting_end_time!)
        meeting_location.text = "\(meetings[indexPath.row].buildingID!)  \(meetings[indexPath.row].roomNumber!)"
        presenter.text = meetings[indexPath.row].meeting_presenter!
        unregisterbutton.layer.borderWidth = 1
        unregisterbutton.layer.cornerRadius = 5
        cell?.backgroundColor = UIColor(red: 237/255, green: 242/255, blue: 240/225, alpha: 1.0)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 10
        
        //on click of unregister
        unregisterbutton.addTarget(self, action: #selector(unregister(sender:)), for: .touchUpInside)
        
        return cell!

    }
    //parsing selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeeting = indexPath.row
    }
    
    //Converting time from string to appropriate string of Date and Time
    func timeConversion(_ dateString:String) -> String{
        let string = dateString
        
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: string)
        dateFormatter.dateFormat = "MM-dd-yyyy h:mm a"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    //size to fit for description Label
    override func viewDidLayoutSubviews() {
        descriptionLBL.sizeToFit()
    }


}
