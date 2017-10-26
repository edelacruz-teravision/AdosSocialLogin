//
//  RequestDebitCardViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 16/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire
import VMaskTextField

class RequestDebitCardViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    // MARK - Global Variables
    
    var pickerNumberOfRows : Int = 0
    var pickerStatesData : [String] = []
    var pickerCitiesData : [String] = []
    var statesResult : [[String : Any]] = [[:]]
    var citiesResult : [[String : Any]] = [[:]]
    var statePicker = UIPickerView()
    var cityPicker = UIPickerView()
    var selectedStateId : Int = 0
    
    // MARK: - Outlets
    
    @IBOutlet var streetAdressTextField: UITextField!
    @IBOutlet var apartmentTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var zipTextField: VMaskTextField!
    
    // MARK: - RequestDebitCardViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.stateTextField.delegate = self
        self.cityTextField.delegate = self
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
        self.cityPicker.delegate = self
        self.cityPicker.dataSource = self
        self.cityTextField.isEnabled = false
        self.zipTextField.delegate = self
        self.zipTextField.mask = "#####"
        loadStates()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        streetAdressTextField.setupTextFields()
        apartmentTextField.setupTextFields()
        stateTextField.setupTextFields()
        cityTextField.setupTextFields()
        zipTextField.setupTextFields()
    }
    
    @IBAction func stateTextFieldEditingBegin(_ sender: UITextField)
    {
        self.cityTextField.text = ""
        self.pickerCitiesData = []
        self.citiesResult = [[:]]
        pickerNumberOfRows = pickerStatesData.count
        
        stateTextField.inputView = statePicker
    }
    
    @IBAction func cityTextFieldEditingBegin(_ sender: UITextField)
    {
        pickerNumberOfRows = pickerCitiesData.count
        
        cityTextField.inputView = cityPicker
    }
    
    // MARK: - Request Later Button Action
    
    @IBAction func requestLaterButtonPressed(_ sender: UIButton)
    {
        self.performSegue(withIdentifier: "goToTermsOfUse", sender: nil)
    }
    
    // MARK: - Continue Button Pressed
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if allTextFieldsFilled(textFields: [self.streetAdressTextField,
                                          self.apartmentTextField,
                                          self.stateTextField,
                                          self.cityTextField,
                                          self.zipTextField])
        {
            if !KVNProgress.isVisible()
            {
                KVNProgress.show(withStatus: "Loading, Please wait")
            }
            
            let requestDebitCardParameters: Parameters = ["city_name" : self.cityTextField.text as AnyObject,
                                                         "state_id" : self.selectedStateId as AnyObject,
                                                         "zip" : self.zipTextField.text as AnyObject,
                                                         "street_address" : self.streetAdressTextField.text as AnyObject,
                                                         "suit_or_apt" : self.apartmentTextField.text as AnyObject]
                     
            let requestDebitCardHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                        "Authorization" : "Bearer \(ServerData.currentToken)"]
            
            Alamofire.request(ServerData.adosUrl + ServerData.requestDebitCard, method: .post, parameters: requestDebitCardParameters, encoding: JSONEncoding.default, headers: requestDebitCardHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
                
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
                        self.performSegue(withIdentifier: "goToTermsOfUse", sender: nil)
                    }
                    
                case .failure( _):
                    
                    self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
            }
        }
        else
        {
            alertBuilder(alertControllerTitle: "Empty field", alertControllerMessage: "Please fill all the fields", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            return
        }
    }
    
    // MARK: - Edit Bar Button Action
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem)
    {
        self.streetAdressTextField.isUserInteractionEnabled = true
        self.apartmentTextField.isUserInteractionEnabled = true
        self.stateTextField.isUserInteractionEnabled = true
        self.cityTextField.isUserInteractionEnabled = true
        self.zipTextField.isUserInteractionEnabled = true
    }
    
    // MARK: - Zip Code Textfields Masking
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return self.zipTextField.shouldChangeCharacters(in: range, replacementString: string)
    }
    
    // MARK: - Api Request For States Picker
    
    func loadStates()
    {
        if !KVNProgress.isVisible()
        {
            KVNProgress.show(withStatus: "Loading, Please wait")
        }
        
        let statesLoaderHeaders : HTTPHeaders = ["Authorization" : "Bearer \(ServerData.currentToken)"]
        
        Alamofire.request(ServerData.adosUrl + ServerData.statesLoader, headers: statesLoaderHeaders).validate(statusCode: 200..<501).responseJSON { response in
            
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
                    self.statesResult = (json["result"] as? [[String: Any]])!
                    
                    for i in 0..<(self.statesResult.count)
                    {
                        let statesDictionary : [String : Any] = self.statesResult[i]
                        self.pickerStatesData.append((statesDictionary["state_name"] as! String) + " (" + (statesDictionary["state_code"] as! String) + ")")
                    }
                    
                    self.loadShippingAdress()
                }
                else
                {
                    print("Error code: \(code)")
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong log in credentials", alertControllerMessage: "Invalid email or password", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            }
        }
    }
    
    // MARK: - Api Request For Shipping Adress
    
    func loadShippingAdress()
    {
        if !KVNProgress.isVisible()
        {
            KVNProgress.show(withStatus: "Loading, Please wait")
        }
        
        let statesLoaderHeaders : HTTPHeaders = ["Authorization" : "Bearer \(ServerData.currentToken)"]
        
        Alamofire.request(ServerData.adosUrl + ServerData.shippingAdress, headers: statesLoaderHeaders).validate(statusCode: 200..<501).responseJSON { response in
            
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
                    KVNProgress.showSuccess()
                    
                    let shippingAdress = (json["result"] as? [String: Any])!
                    
                    self.streetAdressTextField.text = shippingAdress["street_address"] as? String
                    self.apartmentTextField.text = shippingAdress["suite_or_apt"] as? String
                    self.cityTextField.text = shippingAdress["city_name"] as? String
                    self.zipTextField.text = shippingAdress["zip"] as? String
                    
                    for i in 0..<(self.statesResult.count)
                    {
                        let statesDictionary : [String : Any] = self.statesResult[i]
                        
                        if (statesDictionary["id"] as? Int) == (shippingAdress["state_id"] as? Int)
                        {
                            self.stateTextField.text = statesDictionary["state_name"] as? String
                            self.selectedStateId = (statesDictionary["id"] as? Int)!
                        }
                    }
                }
                else
                {
                    print("Error code: \(code)")
                    KVNProgress.dismiss()
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong log in credentials", alertControllerMessage: "Invalid email or password", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.dismiss()
            }
        }
    }
    
    // MARK: - Api Request For Cities Picker
    
    func loadCities(stateId : String)
    {
        KVNProgress.show(withStatus: "Loading, Please wait")
        
        let headers : HTTPHeaders = ["Authorization":"Bearer \(ServerData.currentToken)"]
        
        print("Servicio: \(ServerData.citiesLoader + stateId)")
        
        Alamofire.request(ServerData.adosUrl + ServerData.citiesLoader + stateId, headers: headers).validate(statusCode: 200..<501).responseJSON { response in
            
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
                    KVNProgress.dismiss()
                    
                    self.citiesResult = (json["result"] as? [[String: Any]])!
                    
                    for i in 0..<((self.citiesResult.count))
                    {
                        let citiesDictionary : [String : Any] = self.citiesResult[i]
                        self.pickerCitiesData.append(citiesDictionary["city"] as! String)
                    }
                }
                else
                {
                    print("Error code: \(code)")
                    KVNProgress.dismiss()
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong log in credentials", alertControllerMessage: "Invalid email or password", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.dismiss()
            }
        }
    }
    
    // MARK: - States / Cities Status Picker Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerNumberOfRows
    }
    
    // MARK: - State / City Picker Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if stateTextField.isEditing
        {
            return pickerStatesData[row]
        }
        else
        {
            return pickerCitiesData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if stateTextField.isEditing
        {
            var stateId : String = ""
            
            stateTextField.text = pickerStatesData[row]
            
            for i in 0..<(self.statesResult.count)
            {
                let statesDictionary : [String : Any] = self.statesResult[i]
                
                if ((statesDictionary["state_name"] as! String) + " (" + (statesDictionary["state_code"] as! String) + ")") == stateTextField.text
                {
                    self.selectedStateId = (statesDictionary["id"] as! Int)
                    stateId = String(describing: statesDictionary["id"]!)
                }
            }
            
            loadCities(stateId: stateId)
            
            cityTextField.isEnabled = true
        }
        else
        {
            cityTextField.text = pickerCitiesData[row]
        }
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToFunding"
        {
            if let _ = segue.destination as? FundingViewController
            {
                self.title = ""
            }
        }
    }
}
