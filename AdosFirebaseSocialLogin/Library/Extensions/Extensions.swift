//
//  Extensions.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 10/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

// MARK: - UITextField Extensions

extension UISwitch
{
    func switchState() -> String
    {
        if self.isOn
        {
            return "Yes"
        }
        else
        {
            return "No"
        }
    }
}

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

extension UIViewController : UITextFieldDelegate
{
    // MARK: - Hide Keyboard when hit Enter
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool // Hides keyboard when tap enter
    {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Hide When Tapping Arround
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
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
    
    // MARK: - Email and password validation
    
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
    
    // MARK: - Date Picker Toolbar
    
    func pickerToolbarBuilder(sender: UIViewController, labelText: String) -> UIToolbar
    {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        
        toolbar.barStyle = UIBarStyle.blackTranslucent
        
        toolbar.tintColor = UIColor.white
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed(sender:)))
        
        let flexButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width/3, height: 40))
        
        label.font = UIFont.systemFont(ofSize: 14)
        
        label.textColor = UIColor.white
        
        label.textAlignment = NSTextAlignment.center
        
        label.text = labelText
        
        let labelButton = UIBarButtonItem(customView: label)
        
        toolbar.setItems([flexButton, labelButton, flexButton, doneButton], animated: true)
        
        return toolbar
    }
    
    func donePressed(sender: UIBarButtonItem)
    {
        
    }
    
    // MARK: - All textfields filled validation
    
    func allTextFieldsFilled(textFields: [UITextField]) -> Bool
    {
        for textfield in textFields
        {
            if (textfield.text?.isEmpty)!
            {
                return false
            }
        }
        
        return true
    }
}
