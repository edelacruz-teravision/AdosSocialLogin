//
//  AccountTypeCell.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 11/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class AccountTypeCell: UITableViewCell
{
    // MARK: - Outlets
    
    @IBOutlet var cellImge: UIImageView!
    @IBOutlet var cellLabel: UILabel!    
    
    // MARK: - AccountViewController Load
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        /*let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 36.0/255.0, green: 37.0/255.0, blue: 89.0/255.0, alpha: 1)
        self.selectedBackgroundView = backgroundView*/
        
    }
}
