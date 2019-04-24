//
//  ExcersiceTesting.swift
//  Test_IOS_Exapmple
//
//  Created by anhxa100 on 4/16/19.
//  Copyright © 2019 anhxa100. All rights reserved.
//

import Foundation
class ExcerciseTesting {
    
    let guide: String?
    let questionNumber: Int?
    let htmlContent: String?
    let a : String?
    let b: String?
    let c: String?
    let d: String?
    
    init?(jsonExtesting: JSON) {
        guard let _guide = jsonExtesting["HUONGDAN"] as? String else {return nil}
        guard let _questionNumber = jsonExtesting["QUESTTION_NUMBER"] as? Int else {return nil}
        guard let _htlmContent = jsonExtesting["HTML_CONTENT"] as? String else {return nil}
        guard let _a = jsonExtesting["HTML_A"] as? String else {return nil}
        guard let _b = jsonExtesting["HTML_B"] as? String else {return nil}
        guard let _c = jsonExtesting["HTML_C"] as? String else {return nil}
        guard let _d = jsonExtesting["HTML_D"] as? String else {return nil}
        
        self.guide = _guide
        self.questionNumber = _questionNumber
        self.htmlContent = _htlmContent
        self.a = _a
        self.b = _b
        self.c = _c
        self.d = _d
        
    }
}
