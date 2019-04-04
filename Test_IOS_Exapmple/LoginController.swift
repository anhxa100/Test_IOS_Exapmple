//
//  LoginController.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mamaTF: UITextField!
    @IBOutlet weak var childTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    
    static var instance: LoginController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "LoginController") as! LoginController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickLoginButton(_ sender: Any) {
        let inputValidate = Account.DataBeforeValiDate(mother: mamaTF.text, children: childTF.text, pass: passTF.text)
        Account.valiDateLogin(input: inputValidate, success: { [weak self] outPut in
            // Gọi api login and show loading
            AccountAPI.login(with: outPut, result: { acc in
                if acc.metaCode == .success {
                    // Login thanh công chuyển sang man tiep theo
                    DispatchQueue.main.async {
                        if let token = acc.token {
                            USER_DEFAULTS.set(token, forKey: UserDefaultKeys.tokenKey)
                            USER_DEFAULTS.set(outPut.mother, forKey: UserDefaultKeys.userMotherKey)
                            USER_DEFAULTS.set(outPut.children, forKey: UserDefaultKeys.userChildrenKey)
                            let homevc = HomeController.instance
                            self?.present(homevc, animated: true, completion: nil)
                        } else {
                            self?.errorAlert(message: "Vui lòng thử lại")
                        }
                    }
                } else {
                    self?.errorAlert(message: acc.resultMessage)
                }
            })
        }, failure: { [weak self] in
            self?.errorAlert(message: $0)
        })
    }
    
    
    private func errorAlert(message: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let doneAcion = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(doneAcion)
            self.present(alertVC, animated: true, completion: nil)
        }
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
