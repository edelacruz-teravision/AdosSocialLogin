//
//  ForgotPassViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 27/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress

class ForgotPassViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var emailTextField: UITextField!
    
    // MARK: - ForgotPassViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.emailTextField.delegate = self
        self.hideKeyboardWhenTappingArround()
    }
    
    override func viewDidLayoutSubviews()
    {
        self.emailTextField.setupTextFields()
    }
    
    @IBAction func resetButtonPressed(_ sender: UIButton)
    {
        KVNProgress.show(withStatus: "Loading, Please wait")
        
        let parameters: Parameters = [
            "client_id" : ServerData.clientId,
            "client_secret": ServerData.clientSecret,
            "email": self.emailTextField.text ?? ""
        ]
        
        Alamofire.request(ServerData.adosUrl+ServerData.ForgotPasswordUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON{ (response) in
            
            switch response.result
            {
            case .success:
                
                self.alertBuilder(alertControllerTitle: "Confirmation", alertControllerMessage: "An email has been sent to you with instructions for password reset", alertActionTitle: "Ok", identifier: "unwindToAdosLoginViewController", image: "check")
                            
                KVNProgress.showSuccess()
                
                
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong log in credentials", alertControllerMessage: "Invalid email", alertActionTitle: "Ok", identifier: "", image: "img-error")
                
                self.emailTextField.text = ""
                
                KVNProgress.showError()
            }
        }
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

extension ForgotPassViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // Hides keyboard when tap enter
    {
        textField.resignFirstResponder()
        return true
    }
}
