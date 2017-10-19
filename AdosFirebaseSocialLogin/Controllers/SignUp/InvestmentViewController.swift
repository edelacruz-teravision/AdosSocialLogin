//
//  InvestmentViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 13/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class InvestmentViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var investmentTableView: UITableView!
    
    // MARK: - EmploymentStatusViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        investmentTableView.dataSource = self
        investmentTableView.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Continue Button Pressed
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if let indexPath = self.investmentTableView.indexPathForSelectedRow
        {
            let cell : TypeCell = self.investmentTableView.cellForRow(at: indexPath) as! TypeCell
            
            print(cell.cellLabel.text ?? "")
            
            self.performSegue(withIdentifier: "goToRegulatoryQuestios", sender: nil)
        }
        else
        {
            alertBuilder(alertControllerTitle: "", alertControllerMessage: "Plase select one amount of investment", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToRegulatoryQuestios"
        {
            if let regulatoryQuestionsControllerSegue = segue.destination as? RegulatoryQuestionsViewController
            {
                self.title = ""
            }
        }
    }
}

extension InvestmentViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return InvestmentArray.investmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellId = "InvestmentCell"
        let annualIncome =  InvestmentArray.investmentArray[indexPath.row]
        
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
