//
//  SignUp.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 10/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import Foundation
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

class AccountType: NSObject
{
    var name : String!
    var image : UIImage!
    
    init(name: String)
    {
        self.name = name
    }
}

class ResidenceStatus: NSObject
{
    var name : String!
    var image : UIImage!
    
    init(name: String)
    {
        self.name = name
    }
}

class AnnualIncome: NSObject
{
    var name : String!
    var image : UIImage!
    
    init(name: String)
    {
        self.name = name
    }
}

class EmploymentStatus: NSObject
{
    var name : String!
    var image : UIImage!
    
    init(name: String)
    {
        self.name = name
    }
}

class Investment: NSObject
{
    var name : String!
    var image : UIImage!
    
    init(name: String)
    {
        self.name = name
    }
}
