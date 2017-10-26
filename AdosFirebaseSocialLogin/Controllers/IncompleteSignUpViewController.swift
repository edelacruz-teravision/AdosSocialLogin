//
//  IncompleteSignUpViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 25/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class IncompleteSignUpViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var continueButton: UIButton!
    
    // MARK: - IncompleteSignUpViewController Load
    
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
        setupContinueButton()
    }
    
    // MARK: - Continue Button config
    
    fileprivate func setupContinueButton()
    {
        let continueButtonHeight = continueButton.frame.height
        self.continueButton.layer.cornerRadius = continueButtonHeight / 2.0
    }
    
    // MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //SignUpHelper.goToMyStep(step: 13, navigation: self.navigationController!)
        SignUpHelper.goToActualStep(navigation: self.navigationController!)
    }
}
