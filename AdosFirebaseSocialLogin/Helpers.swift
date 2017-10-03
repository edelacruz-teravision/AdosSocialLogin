//
//  Helpers.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 27/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import Foundation
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
    
    func alertBuilder(alertControllerTitle : String, alertControllerMessage : String, alertActionTitle : String, identifier : String, image: String)
    {
        
        let alertControllerTitleChanged : String = """
                                            
\(alertControllerTitle)
"""
        
        let alertController = UIAlertController(title: alertControllerTitleChanged, message: alertControllerMessage, preferredStyle: .alert)
        
        if !image.isEmpty
        {
            let image = UIImage(named: image)
            
            let imageViewAlert = UIImageView(frame: CGRect(x: 122, y: 10, width: 25, height: 25))
            imageViewAlert.image = image
            
            alertController.view.addSubview(imageViewAlert)
        }
        else
        {
            alertController.title = alertControllerTitle
        }
        
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
    
    func isPasswordValid(_ password : String) -> Bool
    {
        let passwordTest = NSPredicate(format: RegExConditions.preCondition, RegExConditions.passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    func isEmailValid(_ email : String) -> Bool
    {
        let emailTest = NSPredicate(format:RegExConditions.preCondition, RegExConditions.emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
