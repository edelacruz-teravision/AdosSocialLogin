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
    }
    
    // MARK: - Resend Code Button Action
    
    @IBAction func resendCodeButtonPressed(_ sender: UIButton)
    {
        alertBuilder(alertControllerTitle: "", alertControllerMessage: "A new code have been sent to your phone", alertActionTitle: "Ok", identifier: "", image: AlertImages.success)
    }
    
    // MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if allTextFieldsFilled(textFields: [codeTextField])
        {
            self.performSegue(withIdentifier: "", sender: nil)
        }
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
