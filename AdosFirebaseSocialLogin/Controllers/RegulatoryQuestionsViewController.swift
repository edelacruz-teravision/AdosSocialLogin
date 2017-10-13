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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
