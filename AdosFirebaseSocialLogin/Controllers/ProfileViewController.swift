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
    var imageUrl : String = ""
    
    // MARK: - ProfileViewController Load

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if self.imageUrl == "Twitter"
        {
            profilePictureImageView.image = #imageLiteral(resourceName: "twitter-117595_1280")
        }
        else if self.imageUrl == "Login Image"
        {
            profilePictureImageView.image = #imageLiteral(resourceName: "no_picture")
        }
        else
        {
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
        self.profileNameLabel.text = self.name
        self.emailProfileLabel.text = self.email
        self.tokenProfileLabel.text = ServerData.currentToken
    }
    
    // MARK: - Status Bar Config
    
    override var preferredStatusBarStyle: UIStatusBarStyle // Changes the status bar color in the specific View
    {
        return .lightContent
    }
}
