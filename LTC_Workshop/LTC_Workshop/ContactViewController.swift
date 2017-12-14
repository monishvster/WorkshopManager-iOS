//
//  ContactViewController.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/14/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import UIKit
import MapKit

class ContactViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let locationTap = UITapGestureRecognizer(target: self, action: #selector(ContactViewController.locationTap))
        location.addGestureRecognizer(locationTap)
        let creditsTap = UITapGestureRecognizer(target: self, action: #selector(ContactViewController.creditsTap))
        creditsLbl.addGestureRecognizer(creditsTap)

        // Do any additional setup after loading the view.
    }
   
    @IBOutlet weak var location: UITextView!
    @IBOutlet weak var creditsLbl: UILabel!

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func locationTap(sender:UITapGestureRecognizer) {
        openMapForPlace()
    }
    
    @objc func creditsTap(sender:UITapGestureRecognizer) {
        let credits:String = "Monish Verma\nHarish Kola"
        
        
        let alertController = UIAlertController(title: "Credits", message: credits, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Close", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    func openMapForPlace() {
        
        let latitude: CLLocationDegrees = 40.3535881
        let longitude: CLLocationDegrees = -94.88601929999999
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Learning and Teaching Center"
        mapItem.openInMaps(launchOptions: options)
    }
    
    


}
