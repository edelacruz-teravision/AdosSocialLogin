//
//  RiskLevelViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 18/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

class RiskLevelViewController: UIViewController
{
    // MARK: - Global Variables
    
    var strategies = [Int]()
    var expectedReturn = [Int]()
    var expectedReturnDictionary = [[Int : Int]]()
    var strategyDictionary = [[String : Any]]()
    var strategyTableDictionary = [String : Any]()
    var collectionViewSelectedCellPercentage = Int()
    var collectionViewSelectedItemPosition = Int()
    
    //MARK: - Outlets
    
    @IBOutlet var expectedReturnCollectionView: UICollectionView!
    @IBOutlet var investmentStrategyTableView: UITableView!
    
    // MARK: - RiskLevel View Controller Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loadPortfolio()
        self.expectedReturnCollectionView.delegate = self
        self.expectedReturnCollectionView.dataSource = self
        self.investmentStrategyTableView.delegate = self
        self.investmentStrategyTableView.dataSource = self
        
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
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
    }
    
    // MARK: - Api Resquest for Porfolio
    
    func loadPortfolio()
    {
        if !KVNProgress.isVisible()
        {
            KVNProgress.show(withStatus: "Loading, Please wait")
        }
        
        let portfolioLoaderHeaders : HTTPHeaders = ["Authorization" : "Bearer \(ServerData.currentToken)"]
        
        Alamofire.request(ServerData.adosUrl + ServerData.portfolioService, headers: portfolioLoaderHeaders).validate(statusCode: 200..<501).responseJSON { response in
            
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
                
                if code == 201
                {
                    let portfolioResult : [[String : Any]] = (json["result"] as? [[String : Any]])!
                    
                    for i in 0..<portfolioResult.count
                    {
                        let portfolioDetailsAndAssets : [String : Any] = portfolioResult[i] as [String : Any]
                        
                        let portfolioDetails : [String : Any] = portfolioDetailsAndAssets["details"] as! [String : Any]
                        
                        let portfolioAssets : [[String : Any]] = portfolioDetailsAndAssets["assets"] as! [[String : Any]]
                        
                        if self.expectedReturn.isEmpty
                        {
                            self.expectedReturn.append(portfolioDetails["percent"] as! Int)
                            self.strategies.append(portfolioAssets.count)
                        }
                        else
                        {
                            let index = self.expectedReturn.insertionIndex(of: portfolioDetails["percent"] as! Int, using: <)
                            
                            self.expectedReturn.insert(portfolioDetails["percent"] as! Int, at: index)
                            self.strategies.insert(portfolioAssets.count, at: index)
                        }
                        
                        for i in 0..<portfolioAssets.count
                        {
                            self.strategyDictionary.append(DictionaryManager.dictionaryBuider(dict: portfolioAssets[i], percent: portfolioDetails["percent"] as! Int))
                        }
                    }
                    
                    for i in 0..<self.expectedReturn.count
                    {
                        self.expectedReturnDictionary.append([self.expectedReturn[i] : self.strategies[i]])
                    }
                    
                    self.expectedReturnCollectionView.reloadData()
                    
                    KVNProgress.showSuccess()
                }
                else
                {
                    print("Error code: \(code)")
                    
                    KVNProgress.showError()
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong log in credentials", alertControllerMessage: "Invalid email or password", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.showError()
            }
        }
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
        print("StrategyDictionary: ", strategyDictionary)
        print("ExpectedReturnDictionary", expectedReturnDictionary)
        return expectedReturnDictionary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "expectedReturnCell", for: indexPath) as! ExpectedReturnCell
        
        for(key, _) in expectedReturnDictionary[indexPath.row]
        {
            cell.percentNumber = String(key)
        }
        
        cell.cellSetup()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as! ExpectedReturnCell
        self.collectionViewSelectedCellPercentage = Int(cell.percentNumber)!
        self.collectionViewSelectedItemPosition = indexPath.row
        self.investmentStrategyTableView.reloadData()
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
        if (expectedReturnCollectionView.indexPathsForSelectedItems?.isEmpty)!
        {
            return 0
        }
        else
        {
            print(collectionViewSelectedItemPosition)
            
            return expectedReturnDictionary[collectionViewSelectedItemPosition][collectionViewSelectedCellPercentage]!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvestmentStrategyCell", for: indexPath) as! InvestmentStrategyCell
        var strategyArray = [[String : Any]]()
        
        for i in 0..<strategyDictionary.count
        {
            if ((strategyDictionary[i])["percent"]) as! Int == collectionViewSelectedCellPercentage
            {
                strategyArray.append(strategyDictionary[i])
            }
        }
        
        cell.strategyNameLabel.text = (strategyArray[indexPath.row])["name"] as? String
        cell.strategyPercentageLabel.text = (String((strategyArray[indexPath.row])["rate"] as! Int) + "%")
        
        return cell
    }
}

extension Collection
{
    func insertionIndex(of element: Self.Iterator.Element, using areInIncreasingOrder: (Self.Iterator.Element, Self.Iterator.Element) -> Bool) -> Index
    {
        return index(where: { !areInIncreasingOrder($0, element) }) ?? endIndex
    }
}
