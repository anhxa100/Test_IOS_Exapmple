//
//  IDExcerciseAPI.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/11/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Alamofire

class IDExcerciseAPI {
    static func getDetailExcerciseWithId(idExc: String, success: @escaping ([Excercise])->(), failure: @escaping ((String)->())) {
        
        let components = URLComponents(scheme: "https", host: BASE_DOMAIN, path: "/get_exe_detail", queryItems: [])
        guard let url = components.url else {
            failure("Vui lòng thử lại")
            return
        }
      
         guard  let userMother = USER_DEFAULTS.string(forKey: UserDefaultKeys.userMotherKey),
                let userChildren = USER_DEFAULTS.string(forKey: UserDefaultKeys.userChildrenKey),
                let token = USER_DEFAULTS.string(forKey: UserDefaultKeys.tokenKey) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "POST"
        let parameters: [String: Any] = [
            "ID_EXCERCISE": idExc,
            "USER_MOTHER": userMother,
            "USER_CHILD": userChildren
        ]
        
        print(parameters)
        urlRequest.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        Alamofire.request(urlRequest).responseJSON{ response in
            guard response.result.error == nil else {
                print("Lỗi khi request: \(response.result.error)")
                return
            }
            
            guard let json = response.result.value as? [String: Any] else {
                print("ERROR didn't get to do Object as JSON from API: \(response.result.error)")
                return
            }
            
            print("ExcerciseJSON: \(json)")
            
            if let errorCode = json["ERROR"] as? String, let message = json["RESULT"] as? String {
                if errorCode == "0000" , let object = json["INFO"] as? [JSON]{
                    var result: [Excercise] = []
                    object.forEach{
                        if let ex = Excercise(json: $0) {
                            result.append(ex)
                        }
                    }
                    success(result)
                    print(result)
                } else {
                    failure(message)
                }
            } else {
                failure("Đã có lỗi xảy ra, xin mời thử lại")
            }

        }

        
    }
}
