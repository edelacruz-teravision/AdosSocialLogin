//
//  AccountTypeCell.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 11/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class TypeCell: UITableViewCell
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
    }
}
