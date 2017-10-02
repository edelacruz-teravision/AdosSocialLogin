//
//  SignInViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 2/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

class SignInViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var questionButton: UIButton!
    
    // MARK: - SingInViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    override func viewDidLayoutSubviews()
    {
        emailTextField.setupTextFields()
        passwordTextField.setupTextFields()
        confirmPasswordTextField.setupTextFields()
    }
    
    // MARK: - Create Button Action
    
    @IBAction func createButtonPressed(_ sender: UIButton)
    {
        KVNProgress.show(withStatus: "Loading, Please wait")
        
        let parameters: Parameters = [
            "client_id" : ServerData.clientId,
            "client_secret": ServerData.clientSecret,
            "email": emailTextField.text ?? "",
            "password" : passwordTextField.text ?? "",
            "password_confirmation" : confirmPasswordTextField.text ?? "",
            "device_token" : ServerData.deviceToken
        ]
        
        Alamofire.request(ServerData.adosUrl+ServerData.loginUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON{ (response) in
            
            switch response.result
            {
            case .success:
                
                let conditions = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z$@$#!%*?&0-9]{8,}"
                
                func isPasswordValid(_ password : String) -> Bool
                {
                    let passwordTest = NSPredicate(format: "SELF MATCHES %@", conditions)
                    return passwordTest.evaluate(with: password)
                }
                
                let password = "Qwerty123$"
                
                isPasswordValid(password)
                
                KVNProgress.showSuccess()
                
                self.performSegue(withIdentifier: "goToProfileView", sender: nil)
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong sign in credentials", alertControllerMessage: "Invalid email or password", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.showError()
            }
        }
    }
    
    @IBAction func questionButtonPressed(_ sender: UIButton)
    {
        alertBuilder(alertControllerTitle: "", alertControllerMessage: "The password should be a minimum of eight (8) characters, including one (1) special character and one (1) number and combine Uppercase and Lowercase letters.", alertActionTitle: "Ok", identifier: "", image: AlertImages.question)
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
