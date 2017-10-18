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
    
    //MARK: - Outlets
    
    @IBOutlet var expectedReturnCollectionView: UICollectionView!
    
    // MARK: - RiskLevel View Controller Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let itemWidthSize = UIScreen.main.bounds.width / 3
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidthSize, height: 59.0)
        layout.minimumInteritemSpacing = 0
        
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
}
