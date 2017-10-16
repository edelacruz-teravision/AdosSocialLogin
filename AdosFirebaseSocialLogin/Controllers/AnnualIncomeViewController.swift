//
//  AnnualIncomeViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 13/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class AnnualIncomeViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var annualIncomeTableView: UITableView!
    
    // MARK: - AnnualIncomeViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.annualIncomeTableView.dataSource = self
        self.annualIncomeTableView.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Continue Button Pressed
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if let indexPath = self.annualIncomeTableView.indexPathForSelectedRow
        {
            let cell : TypeCell = self.annualIncomeTableView.cellForRow(at: indexPath) as! TypeCell
            
            print(cell.cellLabel.text ?? "")
            
            self.performSegue(withIdentifier: "goToEmploymentStatus", sender: nil)
        }
        else
        {
            alertBuilder(alertControllerTitle: "", alertControllerMessage: "Plase select one annual income", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToEmploymentStatus"
        {
            if let employmentStatusControllerSegue = segue.destination as? EmploymentStatusViewController
            {
                self.title = ""
            }
        }
    }    
}

//MARK: - Table Data Sourse Extension

extension AnnualIncomeViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return AnnualIncomeArray.annualIncomeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cellId = "AnnualIncomeCell"
        
        let annualIncome =  AnnualIncomeArray.annualIncomeArray[indexPath.row]
        
        
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
