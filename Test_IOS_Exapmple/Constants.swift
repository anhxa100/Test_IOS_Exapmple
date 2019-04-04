//
//  Constants.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

let BASE_DOMAIN = "nodejs.home365.online"
let USER_DEFAULTS = UserDefaults.standard

class UserDefaultKeys {
    class var tokenKey: String {
        return "token"
    }
    
    class var userMotherKey: String {
        return "user_mother"
    }
    
    class var userChildrenKey: String {
        return "user_children"
    }
}
