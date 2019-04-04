//
//  ExcerciseAPI.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation

class ExcerciseAPI {
    static func getExcercise(success: @escaping ([Excercise])->(),
                             failure: @escaping ((String)->())) {
        
        let components = URLComponents(scheme: "https", host: BASE_DOMAIN, path: "/get_excercise_needed", queryItems: [])
        guard let url = components.url else {
            failure("Vui lòng thử lại")
            return
        }
        
        guard let userMother = USER_DEFAULTS.string(forKey: UserDefaultKeys.userMotherKey),
            let userChildren = USER_DEFAULTS.string(forKey: UserDefaultKeys.userChildrenKey),
            let token = USER_DEFAULTS.string(forKey: UserDefaultKeys.tokenKey) else {
                failure("Vui lòng đăng nhập")
                return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        let parameters: [String: Any] = [
            "USER_MOTHER": userMother,
            "USER_CHILD": userChildren
        ]
        
        urlRequest.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil, let aData = data else {
               
                failure("Đã có lỗi xảy ra. Vui lòng thử lại")
                
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                
                failure("Đã có lỗi xảy ra. Vui lòng thử lại")
               
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? JSON {
                    if let errorCode = json["ERROR"] as? String, let message = json["RESULT"] as? String {
                        if errorCode == "0000", let object = json["INFO"] as? [JSON] {
                            var result: [Excercise] = []
                            object.forEach {
                                if let ex = Excercise(json: $0) {
                                    result.append(ex)
                                }
                            }
                            success(result)
                        } else {
                            failure(message)
                        }
                    } else {
                        failure("Đã có lỗi xảy ra. Vui lòng thử lại")
                    }
                    
                } else {
                    failure("Đã có lỗi xảy ra. Vui lòng thử lại")
                }
            } catch {
               failure("Đã có lỗi xảy ra. Vui lòng thử lại")
            }
            }.resume()
    }
}
