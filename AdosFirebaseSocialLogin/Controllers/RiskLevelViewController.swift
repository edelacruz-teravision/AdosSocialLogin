//
//  RiskLevelViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 18/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class RiskLevelViewController: UIViewController
{
    // MARK: - Global Variables
    
    let expectedReturn : [String] = ["1", "2", "3", "4", "5", "7", "8"]
    let strategyDictionary : [[String : String]] = [["Us Municipal bonds" : "32.5%"], ["Us Stocks" : "23.0%"], ["Goverment bonds" : "27.0%"], ["Engeneering market stocks" : "10.6%"], ["Us Installation protected bonds" : "7.6%"]]
    
    //MARK: - Outlets
    
    @IBOutlet var expectedReturnCollectionView: UICollectionView!
    
    // MARK: - RiskLevel View Controller Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let itemWidthSize = UIScreen.main.bounds.width / 3
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidthSize, height: 59.0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        expectedReturnCollectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - Extensions

extension RiskLevelViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return expectedReturn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "expectedReturnCell", for: indexPath) as! ExpectedReturnCell
        
        cell.percentNumber = expectedReturn[indexPath.row]
        
        cell.cellSetup()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! ExpectedReturnCell
        cell.cellTaped()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    {
        for index in self.expectedReturnCollectionView.indexPathsForVisibleItems
        {
            if indexPath == index
            {
                let cell = collectionView.cellForItem(at: indexPath) as! ExpectedReturnCell
                cell.cellUtapped()
            }
        }
    }
}

extension RiskLevelViewController: UITableViewDataSource, UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return strategyDictionary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvestmentStrategyCell", for: indexPath) as! InvestmentStrategyCell
        
        for (strategyName, strategyPercentage) in strategyDictionary[indexPath.row]
        {
            cell.strategyNameLabel.text = strategyName
            cell.strategyPercentageLabel.text = strategyPercentage
        }
        
        return cell
    }
}
