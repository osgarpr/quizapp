//
//  ViewController.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 8/30/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set self as the delegate and tablesource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup the model
        model.delegate = self
        model.getQuestions()
    }
    
    func displayQuestion() {
        
        //Check if there are questions and check that the currentQuestionIndex is not out of bound
        guard questions.count > 0 && currentQuestionIndex < questions.count else{
            return
        }
        
        //Display question text
        questionLabel.text = questions[currentQuestionIndex].question
        
        //Reload the answer label
        tableView.reloadData()
        
    }
    
    // MARK: - QuizProtocol Methods
    func questionRetreive(_ questions: [Question]) {
        
        //Get a reference to the questions
        self.questions = questions
        
        //Display the first question
        displayQuestion()
    }
    
    //MARK: -UITableview delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Make sure that the questions array at least have a question
        guard questions.count > 0 else {
            return 0
        }
        
        
        //Return the number of answers for this question
        let currentQuestion = questions[currentQuestionIndex]
        
        if currentQuestion.answers != nil {
            return currentQuestion.answers!.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get a Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        
        //Customize it
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil{
            let question = questions[currentQuestionIndex]
            
            if question.answers != nil && indexPath.row < question.answers!.count {
        
                //Set the answer text for the label
                label!.text = question.answers![indexPath.row]
            }
            
        }
        
        
        //Return the cell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //User have tapped on a row, check if its the right answer
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex! == indexPath.row {
            
            //User got it right
            print("User got it right")
        }
        else {
            
            //User got it wrong
            print("User got it wrong")
        }
        
        //Increment currentQuestionIndex
        currentQuestionIndex += 1
        
        //Display the next question
        displayQuestion()
        
        
    }
    


}

