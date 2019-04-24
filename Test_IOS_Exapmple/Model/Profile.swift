//
//  ProfileAPI.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/12/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
class Profile {
    let fullName : String 
    let phoneNumber: String
    let email: String
    let school: String
    let classStudent: String
    let district: String
    let province: String
    
    init?(jsonProfile: JSON) {
        guard let _fullName = jsonProfile["FULLNAME"] as? String else {return nil}
        guard let _phoneNumber = jsonProfile["PHONENUMBER"] as? String else {return nil}
        guard let _email = jsonProfile["EMAIL"] as? String else {return nil}
        guard let _school = jsonProfile["SCHOOL"] as? String else {return nil}
        guard let _classStudent = jsonProfile["CLASS"] as? String else {return nil}
        guard let _distric = jsonProfile["DISTRIC"] as? String else {return nil}
        guard let _province = jsonProfile["PROVINCE"] as? String else {return nil}
        
        fullName = _fullName
        phoneNumber = _phoneNumber
        email = _email
        school = _school
        classStudent = _classStudent
        district = _distric
        province = _province
        
        print(jsonProfile)
    }
}
