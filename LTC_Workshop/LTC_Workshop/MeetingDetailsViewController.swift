//
//  MeetingDetailsViewController.swift
//  LTC_Workshop
//
//  Created by Harish K on 11/17/16.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit

class MeetingDetailsViewController: UIViewController {
    
    @IBOutlet weak var unregisterBTN: UIButton!
    
    @IBOutlet weak var registreBTN: UIButton!
    
    @IBOutlet weak var presenterLBL: UILabel!
    
    @IBOutlet weak var locationLBL: UILabel!
    @IBOutlet weak var meetingendtimeLBL: UILabel!
    @IBOutlet weak var mtngStartTimeLBL: UILabel!
    var meetingClass:Meeting!
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout(buttonName: registreBTN)
        buttonLayout(buttonName: unregisterBTN)
        
        unregisterBTN.isHidden = true
        displayingMeetingDetails()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonLayout(buttonName:UIButton)
    {
        buttonName.layer.cornerRadius = 10
        buttonName.layer.borderWidth = 1
    }
    
    
    
    @IBAction func unregisterAction(_ sender: AnyObject) {
        
        unregisterBTN.isHidden = true
        registreBTN.isHidden = false
    }
    
    
    @IBAction func registerAction(_ sender: AnyObject) {
        
        registreBTN.isHidden = true
        unregisterBTN.isHidden = false
        
    }
    func displayingMeetingDetails()
    {
        mtngStartTimeLBL.text = meetingClass.meeting_start_time
        meetingendtimeLBL.text = meetingClass.meeting_end_time
        locationLBL.text = meetingClass.meeting_location
        presenterLBL.text = meetingClass.meeting_presenter
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
