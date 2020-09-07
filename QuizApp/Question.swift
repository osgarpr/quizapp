//
//  Question.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 8/30/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import Foundation

struct Question : Codable {
    
    var question:String?
    var answers:[String]?
    var correctAnswerIndex:Int?
    var feedback:String?
    
}
