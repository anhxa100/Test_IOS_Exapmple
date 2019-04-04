//
//  ViewController.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    static var instance : HomeController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeController") as! HomeController
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var excercise: [Excercise] = [] {
        didSet {
//            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // show loading
        ExcerciseAPI.getExcercise(success: { [weak self] exc in
            DispatchQueue.main.async {
                self?.excercise = exc
                /// End loading
                
            }
        }, failure: { [weak self] mess in
            DispatchQueue.main.async {
                /// End loading
                self?.errorAlert(message: mess)
                
            }
        })
    }

    private func errorAlert(message: String) {
        
        let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let doneAcion = UIAlertAction(title: "OK", style: .default, handler: { _ in
            if message.contains("Vui lòng đăng nhập") {
                let loginvc = LoginController.instance
                self.present(loginvc, animated: true, completion: nil)
            }
        })
        alertVC.addAction(doneAcion)
        self.present(alertVC, animated: true, completion: nil)
    }

}

