//
//  StateManager.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 9/22/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import Foundation
class StateManager {
    
    static var numCorrectKey = "NumberCorrectKey"
    static var questionIndexKey = "QuestionIndexKey"
    
    static func safeState(numCorrect:Int, questionIndex:Int) {
        
        //Get a reference to user default
        let defaults = UserDefaults.standard
        
        //Save the state data
        defaults.set(numCorrect, forKey: numCorrectKey)
        defaults.set(questionIndex, forKey: questionIndexKey)
        
    }
    
    static func retreiveValue(key:String) -> Any? {
        
        //Get a reference to user default
        let defaults = UserDefaults.standard
        
        return defaults.value(forKey: key)
        
    }
    
    static func clearState() {
        
        //Get a reference to user default
        let defaults = UserDefaults.standard
        
        //Clear the state data into defaults
        defaults.removeObject(forKey: numCorrectKey)
        defaults.removeObject(forKey: questionIndexKey)
        
        
    }
    
}
