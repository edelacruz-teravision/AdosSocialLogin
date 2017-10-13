//
//  AdressViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 10/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class AdressViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var apartmentTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var zipTextField: UITextField!
    
    // MARK: - AdressViewController Load
    
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
        streetTextField.setupTextFields()
        apartmentTextField.setupTextFields()
        stateTextField.setupTextFields()
        cityTextField.setupTextFields()
        zipTextField.setupTextFields()
    }
    
    // MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        //if allTextFieldsFilled(textFields: [streetTextField, apartmentTextField, stateTextField, cityTextField, zipTextField])
        //{
            self.performSegue(withIdentifier: "goToAccount", sender: nil)
        //}
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToAccount"
        {
            if let accountControllerSegue = segue.destination as? AccountViewController
            {
                self.title = ""
            }
        }
    }
}
