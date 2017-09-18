//
//  ProfileViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo De La Cruz on 17/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var profilePictureImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var emailProfileLabel: UILabel!
    @IBOutlet var tokenProfileLabel: UILabel!
    
    // MARK: - Global Variables
    
    var name : String = ""
    var email : String = ""
    var token : String = ""
    var imageUrl : String = ""
    
    // MARK: - ProfileViewController Load

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.profileNameLabel.text = self.name
        self.emailProfileLabel.text = self.email
        self.tokenProfileLabel.text = self.token
        
        print(self.token)
        
        let url = NSURL(string: imageUrl)
        let data = NSData(contentsOf:url! as URL)
        
        // nil issue manage.
        if (data?.length)! > 0
        {
            self.profilePictureImageView.image = UIImage(data:data! as Data)
        }
        else
        {
            print("Error nil image")
            return
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
