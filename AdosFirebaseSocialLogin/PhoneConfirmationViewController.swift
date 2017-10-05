//
//  PhoneConfirmationViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 5/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class PhoneConfirmationViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var continueButton: UIButton!
    
    //MARK: - PhoneConfirmationViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        codeTextField.delegate = self
    }

    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        codeTextField.setupTextFields()
        continueButton.isEnabled = false
        continueButton.isUserInteractionEnabled = false
    }
    
    @IBAction func codeTextFieldEditingDidEnd(_ sender: UITextField)
    {
        continueButton.isEnabled = true
        continueButton.isUserInteractionEnabled = true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
