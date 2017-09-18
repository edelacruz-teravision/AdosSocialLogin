//
//  ViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo De La Cruz on 16/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class AdosLoginViewController: UIViewController, FBSDKLoginButtonDelegate
{
    // MARK: - Global Variables
    
    var dict : NSDictionary!
    var email : String = ""
    var name : String = ""
    var token : String = ""
    var imageUrl : String = ""
    
    // MARK: - Outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var customFBButton: FBSDKLoginButton!    
    
    // MARK: - AdosLoginViewController Load
    
    override func viewDidLoad()
    {
        // Login button config
        
        super.viewDidLoad()
        
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        self.loginButton.layer.borderWidth = 1
        self.loginButton.layer.cornerRadius = 20
        
        // Textfields config
        
        if let placeholder = passwordTextField.placeholder
        {
            passwordTextField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.4)])
        }
        
        if let placeholder = emailTextField.placeholder
        {
            emailTextField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.4)])
        }
        
        // Custom Facebook button config
        
        customFBButton.delegate = self
        customFBButton.readPermissions = ["email", "public_profile"]
        
        // Creation of FB login button
        
        /*let loginFBButton = FBSDKLoginButton()
        view.addSubview(loginFBButton)
        
        // Frame's are obsolete, please use constraints instead becuase its 2016 afeterall
        
        loginFBButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
        loginFBButton.delegate = self
        loginFBButton.readPermissions = ["email", "public_profile"]*/
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Custom FB Button functions
    
    func handleCustomFBLogin()
    {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, err) in
            if err != nil
            {
                print("FB login Failed", err as Any)
            }
            
            self.showEmailAdress()
        }
    }
    
    // MARK: - FB Button functions
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!)
    {
        FBSDKLoginManager().logOut()
        
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!)
    {
        if error != nil
        {
            print(error.localizedDescription)
            return
        }
        
        self.showEmailAdress()
    }
    
    // MARK: - Custom Functions
    
    func showEmailAdress()
    {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "id, name, email, picture.type(large)"]).start { (connection, result, err) in
            
            if err != nil
            {
                print("Failed to start graph request:", err as Any)
            }
            
            self.dict = result as! NSDictionary
            
            if let email = self.dict["email"]  as? String
            {
                self.email = "Email: " + email
            }
            
            if let token =  FBSDKAccessToken.current()
            {
                self.token = "Access Token: " + token.tokenString
            }
            
            if let name = self.dict["name"]
            {
                self.name = "Name: " + (name as? String)!
            }
            
            if let picture = self.dict["picture"]
            {
                let pictureDic = picture as! NSDictionary
                
                if let data = pictureDic["data"]
                {
                    let dataDic = data as! NSDictionary
                    
                    if let url = dataDic["url"]
                    {
                        self.imageUrl = url as! String
                    }
                }
            }
            
            self.performSegue(withIdentifier: "goToProfileView", sender: nil)
            
        } // Brings your user profile
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let profileViewControllerSegue : ProfileViewController =  segue.destination as! ProfileViewController
        
        profileViewControllerSegue.email = self.email
        profileViewControllerSegue.name = self.name
        profileViewControllerSegue.token = self.token
        profileViewControllerSegue.imageUrl = self.imageUrl
    }
}
