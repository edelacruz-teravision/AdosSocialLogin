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
    @IBOutlet var sSNTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var maritalTextField: UITextField!
    
    //MARK: - PersonalInformationViewController Load
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dateTextfield.delegate = self
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        dateTextfield.setupTextFields()
        firstNameTextField.setupTextFields()
        lastNameTextField.setupTextFields()
        nationalityTextField.setupTextFields()
        sSNTextField.setupTextFields()
        phoneTextField.setupTextFields()
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
        
        let toolBar = dateToolbarBuilder(sender: self)
        
        dateTextfield.inputAccessoryView = toolBar
    }
    
    func datePickerChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        dateTextfield.text = formatter.string(from: sender.date)
    }
    
    override func donePressed(sender: UIBarButtonItem)
    {
        dateTextfield.resignFirstResponder()
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
        if !allTextFieldsFilled(textFields: [dateTextfield, firstNameTextField, lastNameTextField, nationalityTextField, sSNTextField, phoneTextField, maritalTextField])
        {
            alertBuilder(alertControllerTitle: "Empty field", alertControllerMessage: "Please fill all the fields", alertActionTitle: "Ok", identifier: "", image: AlertImages.fail)
            return
        }
        else
        {
            self.performSegue(withIdentifier: "goToPhoneConfirmation", sender: nil)
        }
    }
}
