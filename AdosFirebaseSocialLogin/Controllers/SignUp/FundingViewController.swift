//
//  FundingViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 16/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire
import VMaskTextField

class FundingViewController: UIViewController 
{
    // MARK: - Outlets
    
    @IBOutlet var bankAbaTextField: VMaskTextField!
    @IBOutlet var passwordTextField: VMaskTextField!
    @IBOutlet var benefitiaryTextField: UITextField!
    @IBOutlet var depositAmountTextField: VMaskTextField!
    
    // MARK: - FundingViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        bankAbaTextField.delegate = self
        passwordTextField.delegate = self
        benefitiaryTextField.delegate = self
        depositAmountTextField.delegate = self
        bankAbaTextField.mask = "#########"
        passwordTextField.mask = "##########"
        depositAmountTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
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
        benefitiaryTextField.text = ServerData.userFullName
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
        if allTextFieldsFilled(textFields: [bankAbaTextField,
                                          passwordTextField,
                                          benefitiaryTextField,
                                          depositAmountTextField])
        {
            if !KVNProgress.isVisible()
            {
                KVNProgress.show(withStatus: "Loading, Please wait")
            }
            
            let amount : String = (depositAmountTextField.text?.replacingOccurrences(of: ",", with: ""))!
            
            
            let foundingParameters: Parameters = [
                                                "beneficiary" : self.benefitiaryTextField.text as AnyObject,
                                                "bank_aba_routing" : self.bankAbaTextField.text as AnyObject,
                                                "bank_account_number" : passwordTextField.text as AnyObject,
                                                "amount": ((amount as NSString).doubleValue) as AnyObject
                                                ]
            
            print(((amount as NSString).doubleValue) as AnyObject)
            
            let foundingHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                "Authorization" : "Bearer \(ServerData.currentToken)"]
            
            Alamofire.request(ServerData.adosUrl + ServerData.founding, method: .post, parameters: foundingParameters, encoding: JSONEncoding.default, headers: foundingHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
                
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
                        self.performSegue(withIdentifier: "goToPercentageInvestment", sender: nil)
                    }
                    
                case .failure( _):
                    
                    self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
            }
        }
        else
        {
            alertBuilder(alertControllerTitle: "Empty field", alertControllerMessage: "Please fill all the fields", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            return
        }
        
    }
    
    // MARK: - Format for amount textfields
    
    func myTextFieldDidChange(_ textField: UITextField)
    {
        if let amountString = textField.text?.currencyInputFormatting()
        {
            textField.text = amountString
        }
    }
    
    // MARK: - Ssn / Telephone Textfields masking
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if bankAbaTextField.isEditing
        {
            return bankAbaTextField.shouldChangeCharacters(in: range, replacementString: string)
        }
        else if passwordTextField.isEditing
        {
            return passwordTextField.shouldChangeCharacters(in: range, replacementString: string)
        }
        else
        {
            return true
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToPercentageInvestment"
        {
            if let _ = segue.destination as? InvestmentSelectionViewController
            {
                self.title = ""
            }
        }
    }
}
