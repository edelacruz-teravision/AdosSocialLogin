//
//  Helpers.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 27/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import Foundation
import UIKit
import KVNProgress

// MARK: - UITextField Extensions

extension UITextField
{
    // MARK: - Texfield Setup
    
    func setupTextFields()
    {
        if let placeholder = self.placeholder
        {
            self.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.4)])
        }
    }
}

// MARK: - UIViewController Extensions

extension UIViewController
{
    // MARK: - Hide When Tapping Arround
    
    func hideKeyboardWhenTappingArround() // Hides keyboard when tap on screen
    {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AdosLoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    // MARK: - Dismiss Keyboard
    
    func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    // MARK: - Alert Builder
    
    func alertBuilder(alertControllerTitle : String, alertControllerMessage : String, alertActionTitle : String, identifier : String)
    {
        let alertController = UIAlertController(title: alertControllerTitle, message: alertControllerMessage, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: alertActionTitle, style: .default, handler: {
            (_)in
            if !identifier.isEmpty
            {
                self.performSegue(withIdentifier: identifier, sender: nil)
            }
        })
        
        alertController.addAction(alertAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - KVN Config
    
    func kvnConfiguration()
    {
        let configuration = KVNProgressConfiguration()
        
        configuration.isFullScreen = true
        configuration.errorColor = UIColor.red
        configuration.successColor = UIColor.green
        configuration.backgroundTintColor = UIColor(red: 52, green: 52, blue: 128, alpha: 0.4)
        
        KVNProgress.setConfiguration(configuration)
    }
}
