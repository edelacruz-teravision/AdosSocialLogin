//
//  AccountViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 10/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

class AccountViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var accountTypeTableView: UITableView!
    
    // MARK: - AccountViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.accountTypeTableView.dataSource = self
        self.accountTypeTableView.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if let indexPath = accountTypeTableView.indexPathForSelectedRow
        {
            let cell : TypeCell = accountTypeTableView.cellForRow(at: indexPath) as! TypeCell
            
            if !KVNProgress.isVisible()
            {
                KVNProgress.show(withStatus: "Loading, Please wait")
            }
            
            let accountParameters: Parameters = ["account_type_id" : cell.tag]
            
            let accountHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                            "Authorization" : "Bearer \(ServerData.currentToken)"]
            
            Alamofire.request(ServerData.adosUrl + ServerData.accountType, method: .put, parameters: accountParameters, encoding: JSONEncoding.default, headers: accountHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
                
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
                        self.performSegue(withIdentifier: "goToResidenceStatus", sender: nil)
                    }
                    
                case .failure( _):
                    
                    self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
            }         
        }
        else
        {
            alertBuilder(alertControllerTitle: "", alertControllerMessage: "Plase select one account type", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToResidenceStatus"
        {
            if let _ = segue.destination as? ResidenceStatusViewController
            {
                self.title = ""
            }
        }
    }
}

//MARK: - Table Data Sourse Extension

extension AccountViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return AccountTypeArray.accountTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellId = "AccountTypeCell"
        let accountType = AccountTypeArray.accountTypeArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TypeCell
        
        cell.tag = (indexPath.row + 1)
        cell.cellLabel.text = accountType.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! TypeCell
        cell.cellImge.image = #imageLiteral(resourceName: "selected")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! TypeCell
        cell.cellImge.image = nil
    }
}
