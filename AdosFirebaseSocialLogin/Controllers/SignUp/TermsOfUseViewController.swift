//
//  TermsOfUseViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 16/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

class TermsOfUseViewController: UIViewController
{
    // MARK: - TermsOfUseViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if !KVNProgress.isVisible()
        {
            KVNProgress.show(withStatus: "Loading, Please wait")
        }
        
        let termsOfUseParameters: Parameters = ["action": "accept" as AnyObject]
        
        let termsOfUseHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                        "Authorization" : "Bearer " + ServerData.currentToken]
        
        Alamofire.request(ServerData.adosUrl + ServerData.termsOfUse, method: .post, parameters: termsOfUseParameters, encoding: JSONEncoding.default, headers: termsOfUseHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
            
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
                    KVNProgress.showSuccess()
                    
                    self.performSegue(withIdentifier: "goToFunding", sender: nil)
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.showError()
            }
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToRequestDebitCard"
        {
            if let _ = segue.destination as? RequestDebitCardViewController
            {
                self.title = ""
            }
        }
    }
}
