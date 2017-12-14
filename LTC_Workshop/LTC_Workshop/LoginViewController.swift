//
//  LoginViewController.swift
//  LTC_Workshop
//
//  Created by Harish K on 11/7/16.
//  Modified by Monish V on 6/6/17.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBTN: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonLayout(buttonName: loginBTN)
        userNameTF.autocorrectionType = .no
        passwordTF.autocorrectionType = .no
        self.userNameTF.delegate = self
        self.passwordTF.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func buttonLayout(buttonName:UIButton)
    {
        buttonName.layer.cornerRadius = 10
        buttonName.layer.borderWidth = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginAction(_ sender: AnyObject) {
        let username = userNameTF.text!
        let password = passwordTF.text!
        var request = URLRequest(url: URL(string: "\(Global.hostURL)authenticate?username=\(username)&password=\(password)")!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                
            }
            
            else {
                do {
                    let myResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                    let isAuthenticated:Bool!
                        isAuthenticated = myResponse["isAuthenticated"] as! Bool
                    
                    if(isAuthenticated){
                            DispatchQueue.main.async {
                            
                            let defaults = UserDefaults.standard
                            defaults.setValue(true, forKey: "isLoggedIn")
                            defaults.set(myResponse["username"] as! String, forKey: "UserID")
                            defaults.set(myResponse["accessToken"] as! String, forKey: "Access_Token")
                            defaults.set(myResponse["firstName"] as! String, forKey: "First_Name")
                            defaults.set(myResponse["lastName"] as! String, forKey: "Last_Name")
                            defaults.synchronize()
                                let delegateTemp = UIApplication.shared.delegate
                            delegateTemp?.window!?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabView")
                            return
                        }

                        
                    }
                    else {
                        let refreshAlert = UIAlertController(title: "Error  ", message: "Username/Password is incorrect", preferredStyle: UIAlertControllerStyle.alert)
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            self.userNameTF.text = ""
                            self.passwordTF.text = ""
                        }))
                        self.present(refreshAlert, animated: true, completion: nil)

                    }
                    
                }
                catch let error as NSError {
                    print(error)
                }
            }
            
        }
        task.resume()
    }
    
    
}





