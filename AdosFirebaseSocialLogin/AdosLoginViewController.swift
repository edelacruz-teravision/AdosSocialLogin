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
import TwitterKit
import Alamofire
import KVNProgress

class AdosLoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate
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
    @IBOutlet var customFBButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var customGoogleButton: UIButton!
    @IBOutlet var customTwitterButton: UIButton!
    
    // MARK: - AdosLoginViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        googleDelegateConfig()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.hideKeyboardWhenTappingArround()
        self.kvnConfiguration()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews()
    {
        setupLoginButton()
        setupFacebookButtons()
        setupTextFields()
        setupGoogleButton()
        setupTwitterButton()
    }
    
    // MARK: - Login Button config
    
    fileprivate func setupLoginButton()
    {
        self.loginButtonHeight = loginButton.frame.height
        self.loginButton.layer.cornerRadius = self.loginButtonHeight / 2.0
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
    
    // MARK: - Facebook Button Setup
    
    func setupFacebookButtons()
    {
        let customFBButtonHeight = self.customFBButton.frame.height
        self.customFBButton.layer.cornerRadius = customFBButtonHeight / 2.0
    }
    
    // MARK: - Custom Facebook button action
    
    @IBAction func customFBButtonPressed(_ sender: UIButton)
    {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) { (result, error) in
            if let err = error
            {
                print("Custom FB Login failed", err)
                return
            }
            
            self.facebookLoginAction()
        }
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
    
    // MARK: - Google Button Setup
    
    fileprivate func setupGoogleButton()
    {
        let customGoogleHeight = self.customGoogleButton.frame.height
        self.customGoogleButton.layer.cornerRadius = customGoogleHeight / 2.0
    }
    
    // MARK: - Google Delegate Config

    fileprivate func googleDelegateConfig()
    {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        customGoogleButton.addTarget(self, action: #selector (handleCustomGoogleSign), for: .touchUpInside)
    }
    
    // MARK: - Google Sign In Action
    
    func googleButtonAction()
    {
        self.email = GIDSignIn.sharedInstance().currentUser.profile.email
        self.name = GIDSignIn.sharedInstance().currentUser.profile.name
        self.imageUrl = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 600).absoluteString
        guard let idToken = GIDSignIn.sharedInstance().currentUser.authentication.idToken else { return }
        self.token = idToken
        
        self.performSegue(withIdentifier: "goToProfileView", sender: nil)
    }
    
    // MARK: - Google Button Login / LogOut
    
    func handleCustomGoogleSign()
    {
        if GIDSignIn.sharedInstance().hasAuthInKeychain()
        {
            GIDSignIn.sharedInstance().signOut()
        }
        else
        {
            GIDSignIn.sharedInstance().signIn()
        }
    }
    
    // MARK: - Google Delegate Methods
    
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
    
    // MARK: - Twitter Button Setup
    
    func setupTwitterButton()
    {
        let customTwitterHeight = self.customTwitterButton.frame.height
        self.customTwitterButton.layer.cornerRadius = customTwitterHeight / 2.0
    }
    
    // MARK: - Twitter Button Action
    
    @IBAction func customTwitterButtonPressed(_ sender: TWTRLogInButton)
    {
        Twitter.sharedInstance().logIn(completion: { (session, error) in
            if let err = error
            {
                print("Failed to log in via Twitter", err)
            }
            
            guard let token = session?.authToken else { return }
            guard let secret = session?.authTokenSecret else { return }
            
            let credential = TwitterAuthProvider.credential(withToken: token, secret: secret)
            
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let err = error
                {
                    print("Failed to login to Firebase with Twitter: ", err)
                    return
                }
                
                print("Successfully created a Firebase-Twitter user: ", user?.uid ?? "")
            })
            
            self.token = (session?.authToken)!
            self.name = (session?.userName)!
            self.email = "Not Provided"
            self.imageUrl = "Twitter"
            
            self.performSegue(withIdentifier: "goToProfileView", sender: nil)
        })
    }
    
    // MARK: - Login Button Action
    
    @IBAction func logInButtonPressed(_ sender: UIButton)
    {
        KVNProgress.show()
        
        let parameters: Parameters = [
            "client_id" : ServerData.clientId,
            "client_secret": ServerData.clientSecret,
            "grant_type" : ServerData.grantType,
            "username": emailTextField.text ?? "",
            "password" : passwordTextField.text ?? "",
            "device_token" : ServerData.deviceToken
        ]
        
        Alamofire.request(ServerData.adosUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON{ (response) in
            
            switch response.result
            {
                case .success:
                    guard let json = response.result.value as? [String: Any] else
                    {
                        print("didn't get todo object as JSON from API")
                        print("Error: \(String(describing: response.result.error))")
                        return
                    }
                    
                    let result = json["result"] as? [String: Any]
                    let sigupStatus = result!["signup_status"] as! [String : Any]
                    let data = sigupStatus["data"] as! [[String : Any]]
                    let dataDict = data[0] as [String : Any]
                    let email = dataDict["data"] as! [String : String]
                    
                    self.email = email["email"]!
                    self.imageUrl = "Login Image"
                    self.name = "Not Provided"
                    self.token = result!["access_token"] as! String
                    
                    KVNProgress.showSuccess()
                    //KVNProgress.dismiss()
                
                    self.performSegue(withIdentifier: "goToProfileView", sender: nil)
                
                case .failure( _):
                    let alertController = UIAlertController(title: "Wrong log in credentials", message: "Invalid email or password", preferredStyle: .alert)
                
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                        self.passwordTextField.text = ""
                        self.emailTextField.text = ""
                    })
                    
                    KVNProgress.showError()
                    //KVNProgress.dismiss()
                
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func kvnConfiguration()
    {
        let configuration = KVNProgressConfiguration()
        
        configuration.isFullScreen = true
        configuration.errorColor = UIColor.red
        configuration.successColor = UIColor.green
        configuration.backgroundTintColor = UIColor(red: 52, green: 52, blue: 128, alpha: 0.4)
        
        KVNProgress.setConfiguration(configuration)
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

// MARK: - Extensions

extension AdosLoginViewController
{
    func hideKeyboardWhenTappingArround() // Hides keyboard when tap on screen
    {
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AdosLoginViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
}

extension AdosLoginViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // Hides keyboard when tap enter
    {
        textField.resignFirstResponder()
        return true
    }
}
