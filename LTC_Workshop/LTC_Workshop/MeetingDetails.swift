//
//  NewMeetingDetails.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/12/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import Foundation
struct MeetingDetails
{
    var workshopID:Int!
    var meetingID:Int!
    var buildingID:String!
    var roomNumber:Int!
    var meeting_start_time:String!
    var meeting_end_time:String!
    var meeting_presenter:String!
    var isEnrolled:Bool!
    var isAttended:Bool!
    init()
    {}
    init(workshopID:Int,meetingID:Int,buildingID:String,roomNumber:Int,meeting_start_time:String,meeting_end_time:String,meeting_presenter:String,isEnrolled:Bool,isAttended:Bool)
    {
        self.workshopID = workshopID
        self.meetingID = meetingID
        self.buildingID = buildingID
        self.roomNumber = roomNumber
        self.meeting_end_time = meeting_end_time
        self.meeting_start_time = meeting_start_time
        self.meeting_presenter = meeting_presenter
        self.isEnrolled = isEnrolled
        self.isAttended = isAttended
    }
}
