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

class SignUpViewController: UIViewController
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
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        emailTextField.setupTextFields()
        passwordTextField.setupTextFields()
        confirmPasswordTextField.setupTextFields()
    }
    
    // MARK: - Create Button Action
    
    @IBAction func createButtonPressed(_ sender: UIButton)
    {
        if !allTextFieldsFilled(textFields: [emailTextField, passwordTextField, confirmPasswordTextField])
        {
            alertBuilder(alertControllerTitle: "Empty field", alertControllerMessage: "Please fill all the fields", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            return
        }
        else if confirmPasswordTextField.text != passwordTextField.text
        {
            alertBuilder(alertControllerTitle: "", alertControllerMessage: "Password and confirm password must be identical", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            return
        }
        else if !isPasswordValid(passwordTextField.text!)
        {
            alertBuilder(alertControllerTitle: "Invalid Password", alertControllerMessage: "The password should be a minimum of eight (8) characters, including one (1) special character and one (1) number and combine Uppercase and Lowercase letters.", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
        }
        else if !isEmailValid(emailTextField.text!)
        {
            alertBuilder(alertControllerTitle: "Invalid email", alertControllerMessage: "Please introduce a valid email", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
        }
        else
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
            
            Alamofire.request(ServerData.adosUrl + ServerData.signUpUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate(statusCode: 200..<501).responseJSON{ (response) in
                
                switch response.result
                {
                    case .success:
                        
                        let code = response.response!.statusCode
                        
                        guard let json = response.result.value as? [String: Any] else
                        {
                            print("didn't get todo object as JSON from API")
                            print("Error: \(String(describing: response.result.error))")
                            return
                        }
                        
                        if code != 200
                        {
                            self.alertBuilder(alertControllerTitle: "Sign In Error", alertControllerMessage: json["message"] as! String, alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                            
                            KVNProgress.showError()
                        }
                        else
                        {
                            KVNProgress.showSuccess()
                            self.performSegue(withIdentifier: "goToPersonalInformation", sender: nil)
                        }
                    
                    case .failure( _):
                        
                        self.alertBuilder(alertControllerTitle: "Sign In Error", alertControllerMessage: "Connection failure, please try again", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                        KVNProgress.showError()
                }
            }
        }
    }
    
    // MARK: - Question Button Action
    
    @IBAction func questionButtonPressed(_ sender: UIButton)
    {
        alertBuilder(alertControllerTitle: "", alertControllerMessage: "The password should be a minimum of eight (8) characters, including one (1) special character and one (1) number and combine Uppercase and Lowercase letters.", alertActionTitle: "Ok", identifier: "", image: AlertImages.question)
    }    
   
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToPersonalInformation"
        {
            if let profileViewControllerSegue = segue.destination as? PersonalInformationViewController
            {
                profileViewControllerSegue.navigationController?.setNavigationBarHidden(true, animated: true)
                self.title = ""
                self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 56.0 / 255.0, alpha: 0.1)
                self.navigationController?.view.tintColor = UIColor.white
                self.navigationController?.navigationBar.isTranslucent = true
            }
        }
    }
}
