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
        let attrs = [NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightLight)]
        let percentAttributedString = NSMutableAttributedString(string:percent, attributes:attrs)
        
        let percentNumberAttributedString = NSMutableAttributedString(string:percentNumber, attributes:nil)
        
        
        let percentageString = NSMutableAttributedString()
        percentageString.append(percentNumberAttributedString)
        percentageString.append(percentAttributedString)
        
        self.percentageLabel.attributedText = percentageString
        
        //        self.layer.shadowColor = UIColor.black.withAlphaComponent(0.21).cgColor
        //        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        //        self.layer.shadowRadius = 10.0
        //        self.layer.shadowOpacity = 1.0
        //        self.layer.masksToBounds = false
        //        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    func taped(){
        
        
        //  if self.strategyImageView != UIImageView(image:UIImage(named:"strategyButton.png")){
        
        self.strategyImageView.image = UIImage(named:"strategyButtonSelected.png")
        self.percentageLabel.textColor = UIColor(red: 245.0/255.0, green: 166.0/255.0, blue: 35.0/255.0, alpha: 1.0)
        /*}else{
         self.strategyImageView = UIImageView(image:UIImage(named:"strategyButton.png"))
         self.percentageLabel.textColor = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.40)
         
         }*/
    }
}
