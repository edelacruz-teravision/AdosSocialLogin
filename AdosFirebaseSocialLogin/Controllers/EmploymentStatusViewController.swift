//
//  EmploymentStatusViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 13/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

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
            
            print(cell.cellLabel.text ?? "")
            
            self.performSegue(withIdentifier: "goToInvestment", sender: nil)
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
            if let investmentControllerSegue = segue.destination as? InvestmentViewController
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

