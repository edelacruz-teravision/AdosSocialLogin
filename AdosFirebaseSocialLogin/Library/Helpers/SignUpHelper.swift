//
//  SignUpHelper.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 25/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class SignUpHelper
{
    static func goToActualStep(navigation: UINavigationController)
    {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        var controller = UIViewController()
        var identifier = ""
        
        switch ServerData.actualStep
        {
            case 2:
                identifier = "PersonalInformation"
            case 3:
                identifier = "PhoneConfirmation"
            case 4:
                identifier = "Adress"
            case 5:
                identifier = "Account"
            case 6:
                identifier = "ResidenceStatus"
            case 7:
                identifier = "AnnualIncome"
            case 8:
                identifier = "EmploymentStatus"
            case 9:
                identifier = "Investment"
            case 10:
                identifier = "RegulatoryQuestions"
            case 11:
                identifier = "TermsOfUse"
            case 12:
                identifier = "RequestDebitCard"
            case 13:
                identifier = "Funding"
            case 14:
                identifier = "InvestmentSelection"
            case 15:
                identifier = "RiskLevel"
            default: break            
        }
        
        controller = storyboard.instantiateViewController(withIdentifier: identifier)
        controller.navigationItem.leftBarButtonItem = nil
        controller.navigationItem.hidesBackButton = true
        navigation.show(controller, sender: nil)
    }
}
