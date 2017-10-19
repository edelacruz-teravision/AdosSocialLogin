//
//  InvestmentSelectionViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 16/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

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
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        labelSliderPosition(value: self.investmentSlider.value)
    }
    
    // MARK: - Slider Action
    
    @IBAction func percentageSliderChanged(_ sender: UISlider)
    {
        percentageLabel.text = String(Int(sender.value))+"%"
    }
    
    // MARK: - Percentage Label Position Relative to Slider
    
    func labelSliderPosition(value: Float)
    {
        self.percentageLabel.text = String(Int(value)) + "%"
        let labelXMin = investmentSlider.frame.origin.x + 16
        let labelXMax = investmentSlider.frame.origin.x + investmentSlider.frame.width - 14
        let labelXOffset: CGFloat = labelXMax - labelXMin
        let valueOffset: CGFloat = CGFloat(investmentSlider.maximumValue - investmentSlider.minimumValue)
        let valueDifference: CGFloat = CGFloat(value - investmentSlider.minimumValue)
        let valueRatio: CGFloat = CGFloat(valueDifference/valueOffset)
        let labelXPos = CGFloat(labelXOffset*valueRatio + labelXMin)
        
        self.percentageLabel.frame.origin.x = labelXPos - self.percentageLabel.frame.width/2
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "goToRiskLevel", sender: nil)
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToRiskLevel"
        {
            if let riskLevelControllerSegue = segue.destination as? RiskLevelViewController
            {
                self.title = ""
            }
        }
    }
}
