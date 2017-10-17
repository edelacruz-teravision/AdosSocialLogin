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
    // MARK: - InvestmentSelectionViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Slider Action
    
    @IBAction func percentageSliderChanged(_ sender: UISlider)
    {
        percentageLabel.text = String(Int(sender.value))+"%"
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
