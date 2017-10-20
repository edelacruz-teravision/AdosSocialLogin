//
//  PersonalInformationViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 3/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit
import KVNProgress
import Alamofire

class PersonalInformationViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    //MARK: - Outlets
    
    @IBOutlet var dateTextfield: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var nationalityTextField: UITextField!
    @IBOutlet var sSNTextField: VSTextField!
    @IBOutlet var phoneTextField: VSTextField!
    @IBOutlet var maritalTextField: UITextField!
    
    // MARK: - Global Variables
    
    var pickerNumberOfRows : Int = 0
    var pickerData : [String] = []
    var pickerNationalityData : [String] = []
    var picker = UIPickerView()
    
    
    //MARK: - PersonalInformationViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dateTextfield.delegate = self
        nationalityTextField.delegate = self
        maritalTextField.delegate = self
        picker.delegate = self
        picker.dataSource = self
        loadNationalityOptions()
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        dateTextfield.setupTextFields()
        firstNameTextField.setupTextFields()
        lastNameTextField.setupTextFields()
        nationalityTextField.setupTextFields()
        sSNTextField.setupTextFields()
        sSNTextField.formatting = .socialSecurityNumber
        phoneTextField.setupTextFields()
        phoneTextField.formatting = .phoneNumber
        maritalTextField.setupTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Social Security Number Button Action
    
    @IBAction func infoSSNButtonPressed(_ sender: UIButton)
    {
        alertBuilder(alertControllerTitle: "", alertControllerMessage: "We protect your privacy. Our data is encrypted for your safety. This information is required by the SEC and SIPC in order to open your account", alertActionTitle: "Ok", identifier: "", image: AlertImages.question)
    }
    
    // MARK: - Date TextField Date Picker
    
    @IBAction func dateTextFieldEditing(_ sender: UITextField)
    {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        dateTextfield.inputView = datePicker
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        
        let toolBar = pickerToolbarBuilder(sender: self, labelText: "Select a Date")
        
        dateTextfield.inputAccessoryView = toolBar
    }
    
    func datePickerChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-dd-MM"
        dateTextfield.text = formatter.string(from: sender.date)
    }
    
    // MARK: - Marital Status TextField Picker
    
    @IBAction func maritalTextFieldEditing(_ sender: UITextField)
    {
        pickerData = MaritalStatusArray.maritalStatusArray
        pickerNumberOfRows = pickerData.count
        
        maritalTextField.inputView = picker
    }
    
    // MARK: - Nationality Status TextField Picker
    
    @IBAction func nationalityTextFieldEditing(_ sender: UITextField)
    {
        pickerData = pickerNationalityData
        pickerNumberOfRows = pickerData.count
        
        nationalityTextField.inputView = picker
    }
    
    // MARK: - Picker Textfield Done Editing
    
    override func donePressed(sender: UIBarButtonItem)
    {
        if dateTextfield.isEditing
        {
            dateTextfield.resignFirstResponder()
        }
    }
    
    // MARK: - Status Bar Config
    
    override var preferredStatusBarStyle: UIStatusBarStyle // Changes the status bar color in the specific View
    {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToPhoneConfirmation"
        {
            if let phoneConfirmationControllerSegue = segue.destination as? PhoneConfirmationViewController
            {
                phoneConfirmationControllerSegue.navigationController?.setNavigationBarHidden(false, animated: true)
                self.title = ""
                self.navigationController?.navigationBar.barTintColor = UIColor(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 56.0 / 255.0, alpha: 0.1)
                self.navigationController?.view.tintColor = UIColor.white
                self.navigationController?.navigationBar.isTranslucent = true
            }
        }
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton)
    {
        /*if !allTextFieldsFilled(textFields: [dateTextfield, firstNameTextField, lastNameTextField, nationalityTextField, sSNTextField, phoneTextField, maritalTextField])
        {
            alertBuilder(alertControllerTitle: "Empty field", alertControllerMessage: "Please fill all the fields", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            return
        }
        else
        {*/
            self.performSegue(withIdentifier: "goToPhoneConfirmation", sender: nil)
        //}
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
    
    // MARK: - Nationality / Marital Status Picker Delegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if maritalTextField.isEditing
        {
            maritalTextField.text = pickerData[row]
        }
        else
        {
            nationalityTextField.text = pickerData[row]
        }
    }
    
    // MARK: - Api Request For Nationaliy Picker
    
    func loadNationalityOptions()
    {
        KVNProgress.show(withStatus: "Loading, Please wait")
        
        let headers : HTTPHeaders = ["Authorization":"Bearer \(ServerData.currentToken)"]
        
        Alamofire.request(ServerData.adosUrl + ServerData.countries, headers: headers).validate(statusCode: 200..<500).responseJSON { response in
            
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
                
                    let result = json["result"] as? [[String: Any]]
                    self.pickerData = []
                    
                    for i in 0..<((result?.count)!)
                    {
                        let countrieDictionary : [String : Any] = result![i]
                        self.pickerNationalityData.append(countrieDictionary["full_name"] as! String)
                    }
                }
                else
                {
                    debugPrint("Error code: \(code)")
                    //KVNProgress.showError()
                }
                
            case .failure( _):
                
                self.alertBuilder(alertControllerTitle: "Wrong log in credentials", alertControllerMessage: "Invalid email or password", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
                
                KVNProgress.showError()
            }
        }
    }
}
