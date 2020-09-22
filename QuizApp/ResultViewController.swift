//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Osvaldo Garcia on 9/14/20.
//  Copyright © 2020 Osvaldo Garcia. All rights reserved.
//

import UIKit

protocol ResultViewControllerProtocol {
    func dialogDismissed()
}

class ResultViewController: UIViewController {
    
    @IBOutlet weak var dimView: UIView!
    
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var tittleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    var delegate:ResultViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Round the dialog corners
        dialogView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Now that the elements are loaded, set the TEXT
        tittleLabel.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        
        //Dismiss the Popup
        dismiss(animated: true, completion: nil)
        
        //Notify delegate Popup was dismissed
        delegate?.dialogDismissed()
        
    }
    
}










