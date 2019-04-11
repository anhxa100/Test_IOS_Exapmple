//
//  ProfileVC.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/11/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var imageProfile: UIImageView!
    @IBAction func onClickSignout(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        Switcher.updateRootVC()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
