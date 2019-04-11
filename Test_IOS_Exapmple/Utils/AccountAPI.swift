//
//  AccountAPI.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/4/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
import Alamofire

class AccountAPI {
    static func login(with input: Account.DataAfterValiDate, result: @escaping ((Account)->())) {
        
        let defautError = Account(metaCode: .apiError, message: "Vui lòng liên hệ 1900xxx để được hỗ trợ", token: nil)
//        var queryItems: [URLQueryItem] = []
//        queryItems.append(URLQueryItem(name: "USER_MOTHER", value: input.mother))
//        queryItems.append(URLQueryItem(name: "USER_CHILD", value: input.children))
//        queryItems.append(URLQueryItem(name: "PASSWORD", value: input.pass))
        let components = URLComponents(scheme: "https", host: BASE_DOMAIN, path: "/login_child", queryItems: [])
        //login_child không nên fix cứng
        
        guard let url = components.url else {
            result(defautError)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = "POST"
        let parameters: [String: Any] = [
            "USER_MOTHER": input.mother,
            "USER_CHILD": input.children,
            "PASSWORD": input.pass
        ]
        urlRequest.httpBody = parameters.percentEscaped().data(using: .utf8)
        
        print("USER VA PASS \(parameters)")
        
        //Dùng thư viện alamofire
        Alamofire.request(urlRequest).responseJSON{response in
            guard response.result.error == nil else {
                result(defautError)
                return
            }

            guard let aData = response.result.value as? [String: Any]  else {
                print("didn't get todo object as JSON from API")
                print("Error: \(response.result.error)")
                return
            }
            print("TOKEN O DAY \(aData)")
            result(Account(json: aData))
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                result(defautError)
                return
            }

        }
//          Dùng URLSession cũ
//        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            guard error == nil, let aData = data else {
//
//                result(defautError)
//
//
//                return
//            }
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
//
//                result(defautError)
//
//
//                return
//            }
//
//            do {
//                if let json = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? JSON {
//
//                    result(Account(json: json))
//
//
//                } else {
//
//                    result(defautError)
//
//                }
//            } catch {
//
//                result(defautError)
//
//
//            }
//        }.resume()
    }
}
extension URLComponents {
    init(scheme: String, host: String, path: String, queryItems: [URLQueryItem]) {
        self.init()
        //        let queryItem = URLQueryItem(name: "q", value: "Formula One")
        self.scheme = scheme
        self.host = host
        self.path = path
        self.queryItems = queryItems
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}


