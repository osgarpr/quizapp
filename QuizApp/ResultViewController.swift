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
        
        //Hide the UIElements
        dimView.alpha = 0
        tittleLabel.alpha = 0
        feedbackLabel.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Fade in the elements
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            self.dimView.alpha = 1
            self.tittleLabel.alpha = 1
            self.feedbackLabel.alpha = 1
        }, completion: nil)
    }
    
    
    @IBAction func dismissTapped(_ sender: Any) {
        
        //Fade out the dim view
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.dimView.alpha = 0

            
        }) { (completed) in
            //Dismiss the Popup
            self.dismiss(animated: true, completion: nil)
            
            //Notify delegate Popup was dismissed
            self.delegate?.dialogDismissed()
        }
        
    }
    
}










