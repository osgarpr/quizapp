//
//  ViewController.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 8/30/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        model.getQuestions()
    }
    
    // MARK: - QuizProtocol Methods
    func questionRetreive(_ questions: [Question]) {
        print("questions retreived from model")
        
    }
    


}

