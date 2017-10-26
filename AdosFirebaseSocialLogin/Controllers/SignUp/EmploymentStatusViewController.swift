//
//  EmploymentStatusViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 13/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

class EmploymentStatusViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var employmentStatusTableView: UITableView!
    
    // MARK: - EmploymentStatusViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.employmentStatusTableView.dataSource = self
        self.employmentStatusTableView.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Continue Button Pressed
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if let indexPath = self.employmentStatusTableView.indexPathForSelectedRow
        {
            let cell : TypeCell = self.employmentStatusTableView.cellForRow(at: indexPath) as! TypeCell
            
            if !KVNProgress.isVisible()
            {
                KVNProgress.show(withStatus: "Loading, Please wait")
            }
            
            let employmentStatusParameters: Parameters = ["employment_status_id" : cell.tag as AnyObject]
            
            let employmentStatusHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                     "Authorization" : "Bearer \(ServerData.currentToken)"]
            
            Alamofire.request(ServerData.adosUrl + ServerData.employmentStatus, method: .put, parameters: employmentStatusParameters, encoding: JSONEncoding.default, headers: employmentStatusHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
                
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
                        self.performSegue(withIdentifier: "goToInvestment", sender: nil)
                    }
                    
                case .failure( _):
                    
                    self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
            }         
        }
        else
        {
            alertBuilder(alertControllerTitle: "", alertControllerMessage: "Plase select one emplyment status", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToInvestment"
        {
            if let _ = segue.destination as? InvestmentViewController
            {
                self.title = ""
            }
        }
    }
}

//MARK: - Table Data Sourse Extension

extension EmploymentStatusViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return EmploymentStatusArray.employmentStatusArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellId = "EmploymentStatusCell"
        let annualIncome =  EmploymentStatusArray.employmentStatusArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TypeCell
        
        cell.cellLabel.text = annualIncome.name
        cell.tag = (indexPath.row + 1)
        
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

