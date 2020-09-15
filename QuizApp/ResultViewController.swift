//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 9/14/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var dimView: UIView!
    
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var tittleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Now that the elements are loaded, set the TEXT
        tittleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
        
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
    }
    
}


//TODO: Dismiss POPUP







