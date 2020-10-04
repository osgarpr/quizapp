//
//  ViewController.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 8/30/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource, ResultViewControllerProtocol {
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stackViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    var resultDialog:ResultViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the result dialog
        resultDialog = storyboard?.instantiateViewController(identifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        resultDialog?.delegate = self
        
        //Set self as the delegate and tablesource for the table view
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup the model
        model.delegate = self
        model.getQuestions()
    }
    
    func slideInQuestion() {
        
        //Set initial state
        stackViewLeadingConstraint.constant = -1000
        stackViewTrailingConstraint.constant = 1000
        rootStackView.alpha = 0
        view.layoutIfNeeded()
        
        //Animate it to the end state
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.stackViewLeadingConstraint.constant = 0
            self.stackViewTrailingConstraint.constant = 0
            self.rootStackView.alpha = 1
            self.view.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    func slideOutQuestion() {
        
        //Set initial state
        stackViewTrailingConstraint.constant = 0
        stackViewLeadingConstraint.constant = 0
        rootStackView.alpha = 1
        view.layoutIfNeeded()
        
        //Animate it to the end state
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.stackViewLeadingConstraint.constant = -1000
            self.stackViewTrailingConstraint.constant = 1000
            self.rootStackView.alpha = 0
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
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
        
        //Animate the question in
        slideInQuestion()
        
    }
    
    // MARK: - QuizProtocol Methods
    func questionRetreive(_ questions: [Question]) {
        
        //Get a reference to the questions
        self.questions = questions
        
        //Check if we should restore the state before display question #1
        let saveIndex = StateManager.retreiveValue(key: StateManager.questionIndexKey) as? Int
        
        if saveIndex != nil && saveIndex! < self.questions.count {
            
            //Set the current question to the saveIndex
            currentQuestionIndex = saveIndex!
            
            //Retreive the number of correct from storage
            let saveNumCorrect = StateManager.retreiveValue(key: StateManager.numCorrectKey) as? Int
            
            if saveNumCorrect != nil {
                numCorrect = saveNumCorrect!
            }
            
        }
        
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
        
        var tittleText = ""
        
        //User have tapped on a row, check if its the right answer
        let question = questions[currentQuestionIndex]
        
        if question.correctAnswerIndex! == indexPath.row {
            
            //User got it right
            print("User got it right")
            
            tittleText = "Correct"
            numCorrect += 1
            
        }
        else {
            
            //User got it wrong
            print("User got it wrong")
            
            tittleText = "Wrong!"
            
        }
        
        //Slide out the question
        DispatchQueue.main.async {
            self.slideOutQuestion()
        }
        
        //Show the popup
        if resultDialog != nil {
            
            //Customize the dialog text
            resultDialog!.titleText = tittleText
            resultDialog!.feedbackText = question.feedback!
            resultDialog!.buttonText = "Next"
            
            DispatchQueue.main.async {
                self.present(self.resultDialog!, animated: true, completion: nil)
            }
        }
    }
    //MARK: - ResultViewControllerProtocol Methods
    
    func dialogDismissed() {
        
        //Increment currentQuestionIndex
        currentQuestionIndex += 1
        print(questions.count)
        print(currentQuestionIndex)
        if currentQuestionIndex == questions.count {
            
            
            //The user has just answer the last question
            //Show a summary dialog
            if resultDialog != nil {
                
                //Customize the dialog text
                resultDialog!.titleText = "Summary"
                resultDialog!.feedbackText = "You got \(numCorrect) correct out of \(questions.count) questions"
                resultDialog!.buttonText = "Restart"
                
                present(resultDialog!, animated: true, completion: nil)
                
                //Clear the state
                StateManager.clearState()
                
            }
        }
        else if currentQuestionIndex > questions.count{
            //Restart
            numCorrect = 0
            currentQuestionIndex = 0
            displayQuestion()
            
        }
        else if currentQuestionIndex < questions.count {
                
            //We have more questions to show
            //Display the next question
            displayQuestion()
            
            //Save state
            StateManager.safeState(numCorrect: numCorrect, questionIndex: currentQuestionIndex)
            
            }
        }
    }


