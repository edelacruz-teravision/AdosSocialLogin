//
//  AccountViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 10/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController
{
    // MARK: - Outlets
    
    @IBOutlet var tableView: UITableView!
    
    // MARK: - AccountViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        
    }
    
}

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
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AccountTypeCell
        
        cell.cellLabel.text = accountType.name
        cell.setSelected(false, animated: true)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! AccountTypeCell
        cell.cellImge.image = #imageLiteral(resourceName: "selected")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! AccountTypeCell
        cell.cellImge.image = nil
    }
}
