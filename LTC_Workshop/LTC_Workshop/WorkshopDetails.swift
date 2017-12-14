//
//  NewWorkshopDetails.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/9/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import Foundation
struct WorkshopDetails
{
    var workshopId:Int!
    var workshopName:String!
    var workshopDesc:String!
    var meeting:[MeetingDetails]!
    init()
    {}
    init(workshopId:Int,workshopDesc:String,workshopName:String, meeting:[MeetingDetails]!)
    {
        self.workshopName = workshopName
        self.workshopDesc = workshopDesc
        self.workshopId = workshopId
        self.meeting = meeting
    }
}
