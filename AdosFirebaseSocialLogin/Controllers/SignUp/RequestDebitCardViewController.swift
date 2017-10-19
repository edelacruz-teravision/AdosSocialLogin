//
//  RequestDebitCardViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 16/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class RequestDebitCardViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var streetAdressTextField: UITextField!
    @IBOutlet var apartmentTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var zipTextField: UITextField!
    
    // MARK: - RequestDebitCardViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        streetAdressTextField.setupTextFields()
        apartmentTextField.setupTextFields()
        stateTextField.setupTextFields()
        cityTextField.setupTextFields()
        zipTextField.setupTextFields()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Request Later Button Action
    
    @IBAction func requestLaterButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "goToFunding", sender: nil)
    }
    
    // MARK: - Continue Button Pressed
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "goToFunding", sender: nil)
    }
    
    // MARK: - Edit Bar Button Action
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem)
    {
        streetAdressTextField.isUserInteractionEnabled = true
        apartmentTextField.isUserInteractionEnabled = true
        stateTextField.isUserInteractionEnabled = true
        cityTextField.isUserInteractionEnabled = true
        zipTextField.isUserInteractionEnabled = true
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToFunding"
        {
            if let fundingControllerSegue = segue.destination as? FundingViewController
            {
                self.title = ""
            }
        }
    }
}
