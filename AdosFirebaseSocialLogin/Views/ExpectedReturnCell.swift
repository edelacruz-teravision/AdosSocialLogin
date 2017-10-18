//
//  ExpectedReturnCell.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 18/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class ExpectedReturnCell: UICollectionViewCell
{
    var percentNumber = ""
    
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var strategyImageView: UIImageView!
    
    func cellSetup()
    {
        self.strategyImageView.image = #imageLiteral(resourceName: "strategyButton")
        self.percentageLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.40)
        
        let percent = "%"
        let percentAtributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
        let percentAttributedString = NSMutableAttributedString(string:percent, attributes:percentAtributes)
        
        let percentNumberAtributes = [NSFontAttributeName : UIFont.systemFont(ofSize: 30, weight: UIFontWeightLight)]
        let percentNumberAttributedString = NSMutableAttributedString(string:percentNumber, attributes:percentNumberAtributes)
        
        
        let percentageString = NSMutableAttributedString()
        percentageString.append(percentNumberAttributedString)
        percentageString.append(percentAttributedString)
        
        self.percentageLabel.attributedText = percentageString
    }
    
    func cellTaped()
    {
        self.strategyImageView.image = #imageLiteral(resourceName: "strategyButtonSelected")
        self.percentageLabel.textColor = UIColor(red: 245.0/255.0, green: 166.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    }
}
