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
}

extension AccountViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cellId = "AccountTypeCell"
        let cell = self.tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        return cell
    }
}
