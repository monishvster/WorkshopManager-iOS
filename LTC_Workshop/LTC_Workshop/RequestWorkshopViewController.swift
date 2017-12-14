//
//  RequestWorkshopViewController.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/14/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import UIKit

class RequestWorkshopViewController: UIViewController,UITextFieldDelegate {
    

    @IBOutlet weak var requestTitle: UITextField!
    @IBOutlet weak var requestDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestDescription.layer.borderWidth = 1.0
        requestTitle.layer.borderWidth = 1.0
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RequestWorkshopViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func requestWorkshop(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        let UserID = defaults.string(forKey: "UserID")!
        let AccessToken = defaults.string(forKey: "Access_Token")!
        let First_Name = defaults.string(forKey: "First_Name")!
        let Last_Name = defaults.string(forKey: "Last_Name")!
        let descriptionText:String = requestDescription.text!
        let titleText:String = requestTitle.text!
        

        
        let feedbackURL:String = "\(Global.hostURL)requestworkshop?username=\(UserID)&accessToken=\(AccessToken)&firstname=\(First_Name)&lastname=\(Last_Name)&title=\(titleText)&description=\(descriptionText)"
        if let url = URL(string: feedbackURL) {
            
            let urlRequest = URLRequest(url: url)
            
            let session = URLSession.shared
            
            session.dataTask(with: urlRequest){
                (data, response, err) in
                
                if err != nil {
                    print(err!)
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                }.resume()
        }

    }
    
    
    @IBAction func cancelRequest(_ sender: UIButton) {
        requestTitle.text = ""
        requestDescription.text = ""
        self.navigationController?.popToRootViewController(animated: true)
    }
   

}
