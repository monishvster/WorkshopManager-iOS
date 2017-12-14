//
//  This is extention to UpcomingDetailsViewController and used to show the meeting view to register or unregister.
//  LTC_Workshop
//
//  Created by Harish K on 11/18/16.
//  Modified by Monish V on 9/19/17.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class UpcomingMeetingDetailsViewController: UIViewController {

    //declaring variables
    var meetingClass:MeetingDetails!
    
    //MARK: Outlet
    @IBOutlet weak var registreBTN: UIButton!
    @IBOutlet weak var presenterLBL: UILabel!
    @IBOutlet weak var locationLBL: UILabel!
    @IBOutlet weak var meetingendtimeLBL: UILabel!
    @IBOutlet weak var mtngStartTimeLBL: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting the button layout
        buttonLayout(buttonName: registreBTN)
        
        //displaying meeting details
        displayingMeetingDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //if enrolled set title to unregister and color as red else title to register and color as green
        if meetingClass.isEnrolled {
            registreBTN.setTitle("Unregister", for: .normal)
            registreBTN.backgroundColor = UIColor.red
        }
        else {
            registreBTN.setTitle("Register", for: .normal)
            registreBTN.backgroundColor = UIColor(hex: "5cb85c")
        }
    }

    func buttonLayout(buttonName:UIButton)
    {
        buttonName.layer.cornerRadius = 10
        buttonName.layer.borderWidth = 1
    }
    
    func displayingMeetingDetails()
    {
        mtngStartTimeLBL.text = timeConversion(meetingClass.meeting_start_time)
        meetingendtimeLBL.text = timeConversion(meetingClass.meeting_end_time)
        locationLBL.text = "\(meetingClass.buildingID!)   \(meetingClass.roomNumber!)"
        presenterLBL.text = meetingClass.meeting_presenter
    }
    
    
    //action on register/unregister click
    @IBAction func registerAction(_ sender: AnyObject) {
        
        // if title of button is register, register the user
        if registreBTN.titleLabel?.text == "Register" {
            self.enrollrequest()
            self.navigationController?.popToRootViewController(animated: true)
            
        }
            
            // else unregister the user, before that confirm the user
        else {
            let alertController = UIAlertController(title: "Confirm", message: "Are you sure you want to unregister?", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            }
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                self.enrollrequest()
                self.navigationController?.popToRootViewController(animated: true)
                
            }
            alertController.addAction(cancelAction)
            alertController.addAction(okAction)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
            
            
        }
        
        
        
        
        
    }
    
    //calling GET api to register/unregister user
    func enrollrequest() {
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")
        let AccessToken = defaults.string(forKey: "Access_Token")

        let url:String = "\(Global.hostURL)registermeeting?username=\(UserID!)&accessToken=\(AccessToken!)&meetingId=\(meetingClass.meetingID!)&isRegistered=\(String(meetingClass.isEnrolled))"
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                _ = JSON(data: data)
                //self.navigationController?.popToRootViewController(animated: true)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //convert time to required format
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
