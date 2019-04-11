//
//  Excercise.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

class Excercise {
    let levelName: String
    let subjectName: String
    let weekName: String
    let requirement: String
    
    init?(json: JSON) {
        guard let _levelName = json["LEVEL_NAME"] as? String else {return nil}
        guard let _subjectName = json["SUBJECT_NAME"] as? String else {return nil}
        guard let _weekName = json["WEEK_NAME"] as? String else {return nil}
        guard let _requirement = json["REQUIREMENT"] as? String else {return nil}
        
        levelName = _levelName
        subjectName = _subjectName
        weekName = _weekName
        requirement = _requirement
        
//        print(levelName)
//        print(subjectID)
//        print(weekName)
//        print(requirement)
        
        print(json)
        
        
    }
}
