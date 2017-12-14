//
//  ProfileViewController.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/14/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var privacySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")
        let AccessToken = defaults.string(forKey: "Access_Token")
        let First_Name = defaults.string(forKey: "First_Name")
        nameLBL.text = "Hi \(First_Name!)"
        

        let url:String =  "\(Global.hostURL)privacysettings?username=\(UserID!)&accessToken=\(AccessToken!)"
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                let json = JSON(data: data)
                if !json.bool! {
                    privacySwitch.setOn(false, animated: true)
                }
                else {
                    privacySwitch.setOn(true, animated: true)
                }
                
                
            }
        }

        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func logoutBar(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set("", forKey: "UserID")
        defaults.set("", forKey: "Access_Token")
        defaults.setValue(false, forKey: "isLoggedIn")
        defaults.synchronize()
        
        UIApplication.shared.delegate?.window!?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView")
        
    }
    
    
    
    @IBAction func privacySwitch(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")
        let AccessToken = defaults.string(forKey: "Access_Token")
        if privacySwitch.isOn {
            var request = URLRequest(url: URL(string: "\(Global.hostURL)privacysettings?username=\(UserID!)&accessToken=\(AccessToken!)&isShownInLeaderboard=true")!)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
               
            })
            task.resume()
            
        }
        else {
            var request = URLRequest(url: URL(string: "\(Global.hostURL)privacysettings?username=\(UserID!)&accessToken=\(AccessToken!)&isShownInLeaderboard=false")!)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
                
            })
            task.resume()
        }
        
    }

    //locking orientation to portrait
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }
    
    //disable autorotate
    open override var shouldAutorotate: Bool {
        get {
            return false
        }
    }

}
