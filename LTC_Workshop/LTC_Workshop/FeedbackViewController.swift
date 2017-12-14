//
//  This class is for giving feedback for an attended workshop
//  LTC_Workshop
//
//  Created by Harish K on 11/7/16.
//  Modified by Monish V on 9/19/17.
//
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class FeedbackViewController: UIViewController, UITextFieldDelegate {
    
    // Declaring variables
    var meetingClass:MeetingDetails!
    var newworkshopClass:WorkshopDetails!
    
    //MARK: OUTLETS
    @IBOutlet weak var workshopTitle: UILabel!
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var isRecommended: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting name and color of navigation bar
        self.navigationItem.title = "Feedback"
        self.navigationController?.navigationBar.tintColor = UIColor.white
        workshopTitle.text = newworkshopClass.workshopName
        comments.layer.borderWidth = 1.0
        workshopTitle.layer.borderWidth = 1.0
        self.automaticallyAdjustsScrollViewInsets = false
        
        //adding tap gesture to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FeedbackViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    //dismissing keyboard on click of return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //Dismiss keyboard when clicked outside the text view
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //action for submit button
    @IBAction func submitFeedback(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")!
        let AccessToken = defaults.string(forKey: "Access_Token")!
        let commentsData:String = comments.text!
        let recommendation:String = String(isRecommended.isOn)
        let workshopID:String = String(newworkshopClass.workshopId)
        
        //POST api call to post feedback
        let feedbackURL:String = "\(Global.hostURL)feedback?username=\(UserID)&accessToken=\(AccessToken)&workshopId=\(workshopID)&feedbackData=\(commentsData)&isRecommended=\(recommendation)"
        if let url = URL(string: feedbackURL) {
            
            let urlRequest = URLRequest(url: url)
            
            let session = URLSession.shared
            
            session.dataTask(with: urlRequest){
                (data, response, err) in
                
                if err != nil {
                    print(err!)
                    return
                }
                //Going back to root controller
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                }.resume()
        }
        
        
    }

}
