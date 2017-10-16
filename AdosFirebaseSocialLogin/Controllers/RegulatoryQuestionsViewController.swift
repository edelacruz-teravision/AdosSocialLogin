//
//  RegulatoryQuestionsViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 13/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class RegulatoryQuestionsViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var nameOfTheFirmStackView: UIStackView!
    @IBOutlet var nameOfTheFirmSwitch: UISwitch!
    @IBOutlet var nameOfTheFirmTextField: UITextField!
    @IBOutlet var companySymbolsStackView: UIStackView!
    @IBOutlet var companySymbolsSwitch: UISwitch!
    @IBOutlet var companySymbolsTextField: UITextField!
    @IBOutlet var politicalOrganizationStackView: UIStackView!
    @IBOutlet var politicalOrganizationSwitch: UISwitch!
    @IBOutlet var politicalOrganizationTextField: UITextField!
    
    // MARK: - RegulatoryQuestionsViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.nameOfTheFirmSwitch.setOn(false, animated: true)
        self.companySymbolsSwitch.setOn(false, animated: true)
        self.politicalOrganizationSwitch.setOn(false, animated: true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        self.nameOfTheFirmTextField.setupTextFields()
        self.companySymbolsTextField.setupTextFields()
        self.politicalOrganizationTextField.setupTextFields()
    }
    
    //MARK: - Name Of The Firm Switch Change

    @IBAction func nameOfTheFirmSwitchChanged(_ sender: UISwitch)
    {
        if sender.isOn
        {
            self.nameOfTheFirmStackView.isHidden = false
        }
        else
        {
            self.nameOfTheFirmStackView.isHidden = true
        }
    }
    
    //MARK: - Company Symbols Switch Change
    
    @IBAction func companySymbolsSwitchChanged(_ sender: UISwitch)
    {
        if sender.isOn
        {
            self.companySymbolsStackView.isHidden = false
        }
        else
        {
            self.companySymbolsStackView.isHidden = true
        }
    }
    
    //MARK: - Political Organization Switch Change
    
    @IBAction func politicalOrganizationSwitchChanged(_ sender: UISwitch)
    {
        if sender.isOn
        {
            self.politicalOrganizationStackView.isHidden = false
        }
        else
        {
            self.politicalOrganizationStackView.isHidden = true
        }
    }
    
    //MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "goToTermsOfUse", sender: nil)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToTermsOfUse"
        {
            if let termsOfUseControllerSegue = segue.destination as? TermsOfUseViewController
            {
                self.title = ""
            }
        }
    }
}
