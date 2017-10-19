//
//  PersonalInformationViewController.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 3/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class PersonalInformationViewController: UIViewController
{
    //MARK: - Outlets
    
    @IBOutlet var dateTextfield: UITextField!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var nationalityTextField: UITextField!
    @IBOutlet var sSNTextField: VSTextField!
    @IBOutlet var phoneTextField: VSTextField!
    @IBOutlet var maritalTextField: UITextField!
    
    //MARK: - PersonalInformationViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dateTextfield.delegate = self
        nationalityTextField.delegate = self
        maritalTextField.delegate = self
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
    
    @IBAction func maritalTextFieldEditin(_ sender: UITextField)
    {
        /*pickerNumberOfRows = MaritalStatusArray.maritalStatusArray.count
        pickerData = MaritalStatusArray.maritalStatusArray*/
        let maritalPicker = UIPickerView()
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int
        {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
        {
            return MaritalStatusArray.maritalStatusArray.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
        {
            return MaritalStatusArray.maritalStatusArray[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            
        }
        
        maritalTextField.inputView = pickerView
        
        let toolBar = pickerToolbarBuilder(sender: self, labelText: "Select a Marital Status")
        
        maritalTextField.inputAccessoryView = toolBar
    }
    
    // MARK: - Picker Textfield Done Editing
    
    override func donePressed(sender: UIBarButtonItem)
    {
        if dateTextfield.isEditing
        {
            dateTextfield.resignFirstResponder()
        }
        else if maritalTextField.isEditing
        {
            maritalTextField.resignFirstResponder()
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
}

/*extension PersonalInformationViewController: UIPickerViewDataSource,UIPickerViewDelegate
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        print(pickerNumberOfRows)
        return pickerNumberOfRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        print(pickerData[row])
        return pickerData[row]
    }
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        maritalStatusString = pickerData[row]
    }*/
}*/
