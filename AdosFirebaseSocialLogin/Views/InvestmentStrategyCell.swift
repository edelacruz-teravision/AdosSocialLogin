//
//  InvestmentStrategyCell.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 19/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class InvestmentStrategyCell: UITableViewCell
{
    // MARK: - Outlets
    
    @IBOutlet var strategyNameLabel: UILabel!
    @IBOutlet var strategyPercentageLabel: UILabel!
    
    // MARK: - Predefined Methods
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
