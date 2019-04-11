//
//  Switcher.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/11/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import UIKit

class Switcher {
    static func updateRootVC() {
        
        let rootVC: UIViewController?
        let loginStatus = UserDefaults.standard.bool(forKey: "isLogin" )
        
        print("Trang Thai LogIn\(loginStatus)")


        if (loginStatus == true) {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabarvc")
        } else {
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController")
        }
        
        let appDelegate = UIApplication.shared.delegate as!  AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
