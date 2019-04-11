//
//  ViewController.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    static var instance : HomeController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeController") as! HomeController
    }
    
    
    
    private var excercise: [Excercise] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        
        // show loading
        ExcerciseAPI.getExcercise(success: { [weak self] exc in
            DispatchQueue.main.async {
                self?.excercise = exc
                //                print(exc)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.levelNameLabel.text = excercise[indexPath.row].levelName
        cell.subjectIDLabel.text = String(excercise[indexPath.row].subjectName)
        cell.weekNameLabel.text = excercise[indexPath.row].weekName
        cell.requirementLabel.text = excercise[indexPath.row].requirement
        
        return cell
    }
    
    
    
}

