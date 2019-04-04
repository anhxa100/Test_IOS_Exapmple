//
//  Account.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>

class Account {
    let metaCode: MetaCode
    let resultMessage: String
    let token: String?
    init(metaCode: MetaCode, message: String, token: String?) {
        self.metaCode = metaCode
        self.resultMessage = message
        self.token = token
    }
    
    convenience init(json: JSON) {
        var _metaCode: MetaCode = .apiError

        if let code = json["ERROR"] as? String, let meta_code = MetaCode(rawValue: code) {
            _metaCode = meta_code
        }
        let _message = (json["RESULT"] as? String) ??  "Vui lòng thử lại"
        let _token = json["TOKEN"] as? String
        self.init(metaCode: _metaCode, message: _message, token: _token)
    }
}

// MARK: - <#Mark#>

extension Account {
    typealias DataBeforeValiDate = (mother: String?, children: String?, pass: String?)
    typealias DataAfterValiDate = (mother: String, children: String, pass: String)
    
    static func valiDateLogin(input: DataBeforeValiDate,
                              success: ((DataAfterValiDate)->()),
                              failure: ((String)->())) {
        
        // kiểm tra trường mother có hay không
        guard let motherData = input.mother, !motherData.isEmpty else {
            failure("Vui lòng nhập đủ thông tin")
            return
        }
        
        // Kiễm tra trường mother nhập vào đủ kí tự yêu cầu hay chưa
        guard motherData.count >= 4 else {
            failure("Trường mother phải đủ 4 kí tự trở lên")
            return
        }
        guard !motherData.contains(" ") else {
            failure("Tài khoản không được chứa ký tự trống")
            return
        }
        
        
        guard let childData = input.children, !childData.isEmpty else {
            failure("Vui lòng nhập đủ thông tin")
            return
        }
        
        guard !childData.contains(" ") else {
            failure("Tài khoản không được chứa ký tự trống")
            return
        }
        
        
        guard let passData = input.pass, !passData.isEmpty  else {
            failure("Vui lòng nhập đủ thông tin")
            return
        }
        
        guard passData.count >= 8 else {
            failure("Mật khẩu phải từ 8 kí tự trở lên")
            return
        }
        
        guard !passData.contains(" ") else {
            failure("Mật khẩu không được chứa khoảng trắng")
            return
        }
        
        
        success(DataAfterValiDate(mother: motherData, children: childData, pass: passData))
    }
}
