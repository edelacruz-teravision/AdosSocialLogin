//
//  ViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo De La Cruz on 16/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class AdosLoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate, GIDSignInDelegate
{
    // MARK: - Global Variables
    
    var dict : NSDictionary!
    var email : String = ""
    var name : String = ""
    var token : String = ""
    var imageUrl : String = ""
    var loginButtonHeight : CGFloat = 0
    
    // MARK: - Outlets
    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var customFBButton: FBSDKLoginButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var customGoogleButton: UIButton!
    
    // MARK: - AdosLoginViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupFacebookButtons()
        setupLoginButton()
        setupTextFields()
        setupGoogleButton()
        setupTwitterButton()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if GIDSignIn.sharedInstance().hasAuthInKeychain()
        {
            customGoogleButton.setImage(#imageLiteral(resourceName: "Sign_Out"), for: .normal)
        }
        else
        {
            customGoogleButton.setImage(#imageLiteral(resourceName: "sign_In"), for: .normal)
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super .viewDidAppear(animated)
        
        self.loginButtonHeight = loginButton.frame.height
        self.loginButton.layer.cornerRadius = self.loginButtonHeight / 2.0
    }
    
    // MARK: - Twitter Sign In Button
    
    func setupTwitterButton()
    {
        
    }
    
    // MARK: - Google Sign in Button

    fileprivate func setupGoogleButton()
    {
        customGoogleButton.contentMode = .center
        customGoogleButton.imageView?.contentMode = .scaleAspectFit
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        customGoogleButton.addTarget(self, action: #selector (handleCustomGoogleSign), for: .touchUpInside)
    }
    
    // MARK: - Custom Facebook button config
    
    fileprivate func setupFacebookButtons()
    {
        customFBButton.delegate = self
        customFBButton.readPermissions = ["email", "public_profile"]
    }
    
    // MARK: - Login Button config
    
    fileprivate func setupLoginButton()
    {
        self.loginButton.layer.borderColor = UIColor.white.cgColor
        self.loginButton.layer.borderWidth = 1
    }
    
    // MARK: - Textfields config
    
    fileprivate func setupTextFields()
    {
        if let placeholder = passwordTextField.placeholder
        {
            passwordTextField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.4)])
        }
        
        if let placeholder = emailTextField.placeholder
        {
            emailTextField.attributedPlaceholder = NSAttributedString(string:placeholder, attributes: [NSForegroundColorAttributeName: UIColor.white.withAlphaComponent(0.4)])
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
        
        self.facebookLoginAction()
    }
    
    // MARK: - Facebook Login Action
    
    func facebookLoginAction()
    {
        let accessTokenFB = FBSDKAccessToken.current()
        guard let accesTokenString = accessTokenFB?.tokenString else
        {
            return
        }
        
        let credentials = FacebookAuthProvider.credential(withAccessToken: accesTokenString)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if error != nil
            {
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            
            print("Successfully logged in Firebase with Facebook, our user is: ", user ?? "")
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields" : "id, name, email, picture.type(large)"]).start { (connection, result, err) in
            
            if err != nil
            {
                print("Failed to start graph request:", err ?? "")
                return
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
    
    func googleButtonAction()
    {
        self.email = GIDSignIn.sharedInstance().currentUser.profile.email
        self.name = GIDSignIn.sharedInstance().currentUser.profile.name
        self.imageUrl = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 600).absoluteString
        guard let idToken = GIDSignIn.sharedInstance().currentUser.authentication.idToken else { return }
        self.token = idToken
        
        self.performSegue(withIdentifier: "goToProfileView", sender: nil)
    }
    
    // MARK: - Google Button Login Action
    
    func handleCustomGoogleSign()
    {
        if GIDSignIn.sharedInstance().hasAuthInKeychain()
        {
            GIDSignIn.sharedInstance().signOut()
            customGoogleButton.setImage(#imageLiteral(resourceName: "sign_In"), for: .normal)
        }
        else
        {
            GIDSignIn.sharedInstance().signIn()
            
        }
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!)
    {    
        if let err = error
        {
            print("Failed to log in into Google", err)
        }
        
        print("Successfully logged into Google", user)
        
        guard let idToken = user.authentication.idToken else { return }
        guard let accessToken = user.authentication.accessToken else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let err = error
            {
                print("Failed to create a Firebase User with Google Account: ", err)
                return
            }
            
            guard let uid = user?.uid else { return }
            print("Successfully logged into Firebase with Google", uid)
        }
        
        googleButtonAction()
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!)
    {
        if error != nil
        {
            print("Failed to log out from Google ", error.localizedDescription)
            return
        }
        else
        {
            print("Successfully logged out from Google")
        }
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
