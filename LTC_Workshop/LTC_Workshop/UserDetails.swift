//
//  WorkshopModel.swift
//  LTC_Workshop
//
//  Created by Monish Verma on 6/5/17.
//  Copyright © 2017 Harish K. All rights reserved.
//

import Foundation
class UserDetails
{
    var userID:String!
    var firstName:String!
    var lastName:String!
    var accessToken:String!
    
    init(userID:String,firstName:String,lastName:String,accessToken:String){
        self.userID = userID
        self.firstName = firstName
        self.lastName = lastName
        self.accessToken = accessToken
    }
    
    
}
