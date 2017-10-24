//
//  PhoneConfirmationViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 5/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress

class PhoneConfirmationViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var codeTextField: UITextField!
    
    //MARK: - PhoneConfirmationViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        codeTextField.delegate = self
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        codeTextField.setupTextFields()
    }
    
    // MARK: - Resend Code Button Action
    
    @IBAction func resendCodeButtonPressed(_ sender: UIButton)
    {
        let smsResendHeaders : HTTPHeaders = ["Authorization" : "Bearer \(ServerData.currentToken)"]
        
        Alamofire.request(ServerData.adosUrl + ServerData.resendSms, headers: smsResendHeaders).validate(statusCode: 200..<501).responseJSON { response in
            
            switch response.result
            {
            case .success:
                
                let code = response.response!.statusCode
                
                if code != 201 && code != 200
                {
                    print("Error resendingsending SMS, code: \(code)")
                }
                else
                {
                    self.alertBuilder(alertControllerTitle: "", alertControllerMessage: "A new code have been sent to your phone", alertActionTitle: "Ok", identifier: "", image: AlertImages.success)
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Sms Error", alertControllerMessage: "We had a problem sending your sms for phone confirmation", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            }
        }
    }
    
    // MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        /*if allTextFieldsFilled(textFields: [codeTextField])
        {
            let smsCodeVerificationParameters: Parameters = ["code" : codeTextField.text as AnyObject]
            
            let smsCodeVErificationHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                            "Authorization" : "Bearer \(ServerData.currentToken)"]
            
            Alamofire.request(ServerData.adosUrl + ServerData.personalInformation, method: .post, parameters: smsCodeVerificationParameters, encoding: JSONEncoding.default, headers: smsCodeVErificationHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
                
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
                    
                    if code != 200 && code != 201
                    {
                        self.alertBuilder(alertControllerTitle: "Error", alertControllerMessage: json["message"] as! String, alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                        
                        KVNProgress.showError()
                    }
                    else
                    {
                        KVNProgress.showSuccess()*/
                        
                        self.performSegue(withIdentifier: "goToAdress", sender: nil)
                    /*}
                    
                case .failure( _):
                    
                    self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
            }            
        }*/
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToAdress"
        {
            if let _ = segue.destination as? AdressViewController
            {
                self.title = ""
            }
        }
    }
}
