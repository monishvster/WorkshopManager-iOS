//
//  This is extention to UpcomingViewController and used to show the meeting timings and description of workshop
//  LTC_Workshop
//
//  Created by Harish K on 11/18/16.
//  Modified by Monish V on 9/19/17.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit

class UpcomingDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    //declaring the variables
    var selectedMeeting:Int!
    var workshopClass:WorkshopDetails!
    var meeting:MeetingDetails!
    var meetings:[MeetingDetails] = []

    //MARK: OUTLETS
    @IBOutlet weak var descriptionLBL: UILabel!
    @IBOutlet weak var meetingTBV: UITableView!
    @IBOutlet weak var workshopnameLBL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting title and color of navigation bar also description and name
        self.navigationItem.title = workshopClass.workshopName
        self.meetingTBV.cellLayoutMarginsFollowReadableWidth = false
        descriptionLBL.text = workshopClass.workshopDesc
        workshopnameLBL.text = workshopClass.workshopName
        for index in 0...workshopClass.meeting.count-1 {
            if workshopClass.workshopId == workshopClass.meeting[index].workshopID {
                meetings.append(workshopClass.meeting[index])
            }
        }
        self.meetingTBV.separatorColor = UIColor.clear
        self.meetingTBV.cellLayoutMarginsFollowReadableWidth = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //reloading the table on view appear
            DispatchQueue.main.async {
                self.meetingTBV.reloadData()
            }
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
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
        
        //building a custom cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "upmeeting_cell")
        cell?.preservesSuperviewLayoutMargins = false
        cell?.separatorInset = UIEdgeInsets.zero
        cell?.layoutMargins = UIEdgeInsets.zero
        let meeting_time = cell?.contentView.viewWithTag(200) as! UILabel
        let meeting_image = cell?.contentView.viewWithTag(201) as! UIImageView
        meeting_image.image = UIImage(named:"icons8-Clock-96.png")
       
        meeting_image.layer.borderWidth = 1.0
        meeting_image.layer.masksToBounds = false
        meeting_image.layer.borderColor = UIColor.clear.cgColor
        meeting_image.layer.cornerRadius = meeting_image.frame.size.height/2
        meeting_image.clipsToBounds = true
        
        meeting_time.text = timeConversion(meetings[indexPath.row].meeting_start_time)
        cell?.backgroundColor = UIColor(red: 237/255, green: 242/255, blue: 240/225, alpha: 1.0)
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 1
        cell?.layer.cornerRadius = 2
        return cell!
        
    }
    
    //parsing selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeeting = indexPath.row
    }
    
    //Sending the data to the UpcomingMeetingDetailsViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "upmeeting" {
            if let nextVC = segue.destination as? UpcomingMeetingDetailsViewController {
               nextVC.meetingClass = meetings[(self.meetingTBV.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
    @IBAction func unwindfromRegisterView(_ sender: UIStoryboardSegue) {
    }

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

    //testing new label
    override func viewDidLayoutSubviews() {
        descriptionLBL.sizeToFit()
    }
    
}
