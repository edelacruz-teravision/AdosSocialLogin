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
    // MARK: - Otlets
    
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
        
        let url = NSURL(string: imageUrl)
        let data = NSData(contentsOf:url! as URL)
        
        // It is the best way to manage nil issue.
        if (data?.length)! > 0
        {
            self.profilePictureImageView.image = UIImage(data:data! as Data)
        }
        else
        {
            print("Error nil image")
            return
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
