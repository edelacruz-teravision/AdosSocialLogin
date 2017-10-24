//
//  AdressViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 10/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire
import VMaskTextField

class AdressViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{    
    // MARK: - Outlets
    
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var apartmentTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var zipTextField: VMaskTextField!
    
    // MARK: - Global Variables
    
    var pickerNumberOfRows : Int = 0
    var pickerStatesData : [String] = []
    var pickerCitiesData : [String] = []
    var statesResult : [[String : Any]] = [[:]]
    var citiesResult : [[String : Any]] = [[:]]
    var statePicker = UIPickerView()
    var cityPicker = UIPickerView()
    var selectedStateId : Int = 0
    
    // MARK: - AdressViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        stateTextField.delegate = self
        cityTextField.delegate = self
        statePicker.delegate = self
        statePicker.dataSource = self
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityTextField.isEnabled = false
        zipTextField.delegate = self
        zipTextField.mask = "#####"
        loadStates()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        streetTextField.setupTextFields()
        apartmentTextField.setupTextFields()
        stateTextField.setupTextFields()
        cityTextField.setupTextFields()
        zipTextField.setupTextFields()
    }
    
    // MARK: - State Textfield Picker
    
    @IBAction func stateTextFieldEditingBegin(_ sender: UITextField)
    {
        self.cityTextField.text = ""
        self.pickerCitiesData = []
        self.citiesResult = [[:]]
        pickerNumberOfRows = pickerStatesData.count
        
        stateTextField.inputView = statePicker
    }
    // MARK: - City Textfield Picker
    
    @IBAction func cityTextFieldEditingBegin(_ sender: UITextField)
    {
        pickerNumberOfRows = pickerCitiesData.count
        
        cityTextField.inputView = cityPicker
    }
    // MARK: - Continue Button Action
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        if allTextFieldsFilled(textFields: [streetTextField, apartmentTextField, stateTextField, cityTextField, zipTextField])
        {
            let personalInformationParameters: Parameters = ["street_address" : self.streetTextField.text as AnyObject,
                                                             "suite_or_apt" : self.apartmentTextField.text as  AnyObject,
                                                             "city_name" : self.cityTextField.text as AnyObject,
                                                             "state_id" : self.selectedStateId,
                                                             "zip_code" : self.zipTextField.text as AnyObject]
            
            let personalInformationHeaders : HTTPHeaders = ["Content-Type" : "application/json",
                                                            "Authorization" : "Bearer \(ServerData.currentToken)"]
            
            Alamofire.request(ServerData.adosUrl + ServerData.personalAdress, method: .put, parameters: personalInformationParameters, encoding: JSONEncoding.default, headers: personalInformationHeaders).validate(statusCode: 200..<501).responseJSON{ (response) in
                
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
                        self.performSegue(withIdentifier: "goToAccount", sender: nil)
                    }
 
                case .failure( _):
                    
                    self.alertBuilder(alertControllerTitle: "Something went wrong", alertControllerMessage: "Server down, Try later", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                    
                    KVNProgress.showError()
                }
            }
        }
    }
    
    // MARK: - Zip Code Textfields Masking
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return zipTextField.shouldChangeCharacters(in: range, replacementString: string)        
    }
    
    // MARK: - Api Request For States Picker
    
    func loadStates()
    {
        KVNProgress.show(withStatus: "Loading, Please wait")
        
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
                    KVNProgress.showSuccess()
                    
                    self.statesResult = (json["result"] as? [[String: Any]])!
                    
                    for i in 0..<(self.statesResult.count)
                    {
                        let statesDictionary : [String : Any] = self.statesResult[i]
                        self.pickerStatesData.append((statesDictionary["state_name"] as! String) + " (" + (statesDictionary["state_code"] as! String) + ")")
                    }
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
    
    // MARK: - Nationality / Marital Status Picker Data Source
    
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
        if segue.identifier == "goToAccount"
        {
            if let _ = segue.destination as? AccountViewController
            {
                self.title = ""
            }
        }
    }
}
