//
//  QuizModel.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 8/30/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import Foundation

protocol QuizProtocol {
    func questionRetreive(_ questions:[Question])
}

class QuizModel {
    
    var delegate:QuizProtocol?
    func getQuestions() {
        
        // TODO: Fetch the question
        
        //Notify the delegate of the retreive questions
        delegate?.questionRetreive([Question]())
        
        
        
        
    }
    
    
    
}

