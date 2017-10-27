//
//  InvestmentSelectionViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 16/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress

class InvestmentSelectionViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var percentageLabel: UILabel!
    @IBOutlet var investmentAmountTextField: UITextField!    
    @IBOutlet var availableAmountTextField: UITextField!
    @IBOutlet var alwaysSaveSwitch: UISwitch!
    @IBOutlet var investmentSlider: UISlider!
    
    // MARK: - InvestmentSelectionViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.availableAmountTextField.delegate = self
        self.investmentAmountTextField.delegate = self
        self.investmentAmountTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        self.loadAvailableFounds()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        availableAmountTextField.setupTextFields()
        investmentAmountTextField.setupTextFields()
        self.labelSliderPosition(value: self.investmentSlider.value)
    }
    
    // MARK: - Slider Action
    
    @IBAction func percentageSliderChanged(_ sender: UISlider)
    {
        self.percentageLabel.text = String(Int(sender.value))+"%"
        
        let availableFounds : String = (self.availableAmountTextField.text?.replacingOccurrences(of: ",", with: ""))!
        
        self.investmentAmountTextField.text = String(format: "%.2f", (self.investmentSlider.value / 100) * (availableFounds as NSString).floatValue).currencyInputFormatting()
    }
    
    // MARK: - Percentage Label Position Relative to Slider
    
    func labelSliderPosition(value: Float)
    {
        self.percentageLabel.text = String(Int(value)) + "%"
        let labelXMin = investmentSlider.frame.origin.x + 16
        let labelXMax = investmentSlider.frame.origin.x + investmentSlider.frame.width - 14
        let labelXOffset : CGFloat = labelXMax - labelXMin
        let valueOffset : CGFloat = CGFloat(investmentSlider.maximumValue - investmentSlider.minimumValue)
        let valueDifference: CGFloat = CGFloat(value - investmentSlider.minimumValue)
        let valueRatio : CGFloat = CGFloat(valueDifference/valueOffset)
        let labelXPos = CGFloat(labelXOffset * valueRatio + labelXMin)
        
        self.percentageLabel.frame.origin.x = labelXPos - self.percentageLabel.frame.width/2
    }
    
    // MARK: - Countinue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "goToRiskLevel", sender: nil)
    }
    
    // MARK: - Format for amount textfields
    
    func myTextFieldDidChange(_ textField: UITextField)
    {
        if let amountString = textField.text?.currencyInputFormatting()
        {
            textField.text = amountString
        }
        
        let investmentAmount : String = (self.investmentAmountTextField.text?.replacingOccurrences(of: ",", with: ""))!
        let availableFounds : String = (self.availableAmountTextField.text?.replacingOccurrences(of: ",", with: ""))!
        
        investmentSlider.value = (100 * (investmentAmount as NSString).floatValue) / (availableFounds as NSString).floatValue
    }
    
    // MARK: - Api Resquest for Available Founds
    
    func loadAvailableFounds()
    {
        if !KVNProgress.isVisible()
        {
            KVNProgress.show(withStatus: "Loading, Please wait")
        }
        
        let availableFoundsLoaderHeaders : HTTPHeaders = ["Authorization" : "Bearer \(ServerData.currentToken)"]
        
        Alamofire.request(ServerData.adosUrl + ServerData.currentBalance, headers: availableFoundsLoaderHeaders).validate(statusCode: 200..<501).responseJSON { response in
            
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
                
                if code == 201
                {
                    let dataResult : [String : Any] = (json["result"] as? [String : Any])!
                    let currentBalance : [String : Any] = dataResult["current_balance"] as! [String : Any]                
                              
                    self.availableAmountTextField.text = String(format: "%.2f", currentBalance["total"] as! Double).currencyInputFormatting()
                    
                    KVNProgress.showSuccess()
                }
                else
                {
                    print("Error code: \(code)")
                    
                    KVNProgress.showError()
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong log in credentials", alertControllerMessage: "Invalid email or password", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.showError()
            }
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToRiskLevel"
        {
            if let _ = segue.destination as? RiskLevelViewController
            {
                self.title = ""
            }
        }
    }
}
