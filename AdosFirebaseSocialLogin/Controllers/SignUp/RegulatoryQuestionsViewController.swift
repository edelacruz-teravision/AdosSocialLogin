//
//  RegulatoryQuestionsViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 13/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress

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
        self.nameOfTheFirmTextField.isUserInteractionEnabled = false
        self.companySymbolsTextField.isUserInteractionEnabled = false
        self.politicalOrganizationTextField.isUserInteractionEnabled = false
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
            self.nameOfTheFirmTextField.isUserInteractionEnabled = true
        }
        else
        {
            self.nameOfTheFirmStackView.isHidden = true
            self.nameOfTheFirmTextField.isUserInteractionEnabled = false
        }
    }
    
    //MARK: - Company Symbols Switch Change
    
    @IBAction func companySymbolsSwitchChanged(_ sender: UISwitch)
    {
        if sender.isOn
        {
            self.companySymbolsStackView.isHidden = false
            self.companySymbolsTextField.isUserInteractionEnabled = true
        }
        else
        {
            self.companySymbolsStackView.isHidden = true
            self.companySymbolsTextField.isUserInteractionEnabled = false
        }
    }
    
    //MARK: - Political Organization Switch Change
    
    @IBAction func politicalOrganizationSwitchChanged(_ sender: UISwitch)
    {
        if sender.isOn
        {
            self.politicalOrganizationStackView.isHidden = false
            self.politicalOrganizationTextField.isUserInteractionEnabled = true
        }
        else
        {
            self.politicalOrganizationStackView.isHidden = true
            self.politicalOrganizationTextField.isUserInteractionEnabled = false
        }
    }
    
    //MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if !KVNProgress.isVisible()
        {
            KVNProgress.show(withStatus: "Loading, Please wait")
        }
        
        let regulatoryQuestionsParameters: Parameters = ["regulatory_question_1": nameOfTheFirmSwitch.switchState() as AnyObject,
                                                         "firm_name" : nameOfTheFirmTextField.text as AnyObject,
                                                         "regulatory_question_2": companySymbolsSwitch.switchState() as AnyObject,
                                                         "company_symbols" : companySymbolsTextField.text as AnyObject,
                                                         "regulatory_question_3": politicalOrganizationSwitch.switchState() as AnyObject,
                                                         "is_politically_exposed": politicalOrganizationTextField.text as AnyObject]
        
        let regulatoryQuestionsHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                        "Authorization" : "Bearer " + ServerData.currentToken]
        
        Alamofire.request(ServerData.adosUrl + ServerData.regulatoryQuestions, method: .post, parameters: regulatoryQuestionsParameters, encoding: JSONEncoding.default, headers: regulatoryQuestionsHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
            
            switch response.result
            {
            case .success:
                
                let code = response.response!.statusCode
                
                guard let json = response.result.value as? [String: Any] else
                {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(String(describing: response.result.error))")
                    return
                }
                
                if code != 200 && code != 201
                {
                    self.alertBuilder(alertControllerTitle: "Error", alertControllerMessage: json["message"] as! String, alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
                else
                {
                    KVNProgress.showSuccess()
                    
                    self.performSegue(withIdentifier: "goToRequestDebitCard", sender: nil)
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.showError()
            }
        }        
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToTermsOfUse"
        {
            if let _ = segue.destination as? TermsOfUseViewController
            {
                self.title = ""
            }
        }
    }
}
