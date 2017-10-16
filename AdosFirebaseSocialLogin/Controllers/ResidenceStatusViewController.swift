//
//  ResidenceStatusViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 11/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

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
        if let indexPath = residenceStatusTableView.indexPathForSelectedRow
        {
            let cell : TypeCell = residenceStatusTableView.cellForRow(at: indexPath) as! TypeCell
            
            print(cell.cellLabel.text ?? "")
            
            self.performSegue(withIdentifier: "goToAnnualIncome", sender: nil)
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
            if let annualIncomeControllerSegue = segue.destination as? AnnualIncomeViewController
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
