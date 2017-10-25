//
//  ResidenceStatusViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 11/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import Alamofire
import KVNProgress

class ResidenceStatusViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var residenceStatusTableView: UITableView!
    
    // MARK: - ResidenceStatusViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.residenceStatusTableView.dataSource = self
        self.residenceStatusTableView.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if let indexPath = self.residenceStatusTableView.indexPathForSelectedRow
        {
            let cell : TypeCell = self.residenceStatusTableView.cellForRow(at: indexPath) as! TypeCell
            
            if !KVNProgress.isVisible()
            {
                KVNProgress.show(withStatus: "Loading, Please wait")
            } 
            
            let residenceStatusParameters: Parameters = ["residential_status_id" : cell.tag]
            
            let residenceStatusHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                            "Authorization" : "Bearer \(ServerData.currentToken)"]
            
            Alamofire.request(ServerData.adosUrl + ServerData.residencialStatus, method: .put, parameters: residenceStatusParameters, encoding: JSONEncoding.default, headers: residenceStatusHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
                
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
                        self.performSegue(withIdentifier: "goToAnnualIncome", sender: nil)
                    }
                    
                case .failure( _):
                    
                    self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
            }
        }
        else
        {
            alertBuilder(alertControllerTitle: "", alertControllerMessage: "Plase select one residence status", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToAnnualIncome"
        {
            if let _ = segue.destination as? AnnualIncomeViewController
            {
                self.title = ""
            }
        }
    }
}

//MARK: - Table Data Sourse Extension

extension ResidenceStatusViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return ResidenceStatusArray.residenceStatusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellId = "ResidenceStatusCell"
        let residenceStatus = ResidenceStatusArray.residenceStatusArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TypeCell
        
        cell.tag = (indexPath.row + 1)
        cell.cellLabel.text = residenceStatus.name
        
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
