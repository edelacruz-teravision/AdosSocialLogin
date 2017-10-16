//
//  FundingViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 16/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class FundingViewController: UIViewController 
{
    // MARK: - Outlets
    
    @IBOutlet var bankAbaTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var benefitiaryTextField: UITextField!
    @IBOutlet var depositAmountTextField: UITextField!
    
    // MARK: - FundingViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        bankAbaTextField.setupTextFields()
        passwordTextField.setupTextFields()
        benefitiaryTextField.setupTextFields()
        depositAmountTextField.setupTextFields()
    }
    
    //MARK: - Show Password Button Action
    
    @IBAction func passwordViewButtonPressed(_ sender: UIButton)
    {
        if !passwordTextField.isSecureTextEntry
        {
            passwordTextField.isSecureTextEntry = true
        }
        else
        {
            passwordTextField.isSecureTextEntry = false
        }
    }
    
    //MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        
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
