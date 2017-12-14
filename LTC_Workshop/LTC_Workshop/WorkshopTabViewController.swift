//
//  Tab bar controller, is also the initial view controller
//  LTC_Workshop
//
//  Created by Harish K on 11/7/16.
//  Modified by Monish V on 9/19/17.
//  Copyright © 2016 Harish K. All rights reserved.
//

import UIKit
import SwiftyJSON

class WorkshopTabViewController: UITabBarController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting the color of navigation bar
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "006747")
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}

//conversion of hex to color
extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}


//Declaring global struct to access hostURL
struct Global {
    static var hostURL = "https://cite.nwmissouri.edu/workshopapi/api/"
}

