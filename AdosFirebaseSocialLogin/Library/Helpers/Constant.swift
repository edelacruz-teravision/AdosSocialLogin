//
//  Constant.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 22/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import Foundation
import Alamofire

struct ServerData
{
    static let clientId : String = "2"
    
    static let clientSecret : String = "Uv2Fsi9uW8qv8ueIJlGSjiOTtJRihNHKryEVvlo9"
    
    static let adosUrl : String = "https://webbrokerbeta.teravisiontech.com:8188"
    
    static let loginUrl : String = "/oauth/token"
    
    static let grantType : String = "password"
    
    static let deviceToken : String = "device_token"
    
    static let ForgotPasswordUrl : String = "/api/v1/forgot_password"
    
    static let signUpUrl : String = "/api/v1/sign_up"
    
    static let countries : String = "/api/v1/countries"
    
    static let personalInformation : String = "/api/v1/personal_information"
    
    static let resendSms : String  = "/api/v1/resend_sms_code"
    
    static let citiesLoader : String = "/api/v1/cities?state_id="
    
    static let statesLoader : String =  "/api/v1/states"
    
    static let personalAdress : String = "/api/v1/contact_information"
    
    static let smsVerification : String = "/api/v1/sms_verification"
    
    static let accountType : String = "/api/v1/account_type"
    
    static let residencialStatus : String = "/api/v1/residential_status"
    
    static let annualIncome : String = "/api/v1/annual_income"
    
    static let employmentStatus : String = "/api/v1/employment_status"
    
    static let investmentApi : String = "/api/v1/investment"
    
    static let regulatoryQuestions : String = "/api/v1/regulatory_questions"
    
    static let termsOfUse : String = "/api/v1/agreements"
    
    static let requestDebitCard : String = "/api/v1/debit_card"
    
    static var currentToken : String = ""
    
    static var actualStep : Int = Int()
}

struct AlertImages
{
    static let success : String = "check"
    
    static let fail : String = "img-error"
    
    static let question : String = "question"
}

struct RegExConditions
{
    static let passwordRegEx = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z$@$#!%*?&0-9]{8,}"
    
    static let preCondition = "SELF MATCHES %@"
    
    static let emailRegEx = "([\\w-+]+(?:\\.[\\w-+]+)*@(?:[\\w-]+\\.)+[a-zA-Z]{2,7})"
}

struct AccountTypeArray
{
    static var accountTypeArray : [AccountType] = [AccountType(name: "Individual"),
                                                 AccountType(name: "Joint"),
                                                 AccountType(name: "IRA"),
                                                 AccountType(name: "401k")]
}

struct ResidenceStatusArray
{
    static var residenceStatusArray : [ResidenceStatus] = [ResidenceStatus(name: "US Citizen"),
                                                         ResidenceStatus(name: "Green Card holder"),
                                                         ResidenceStatus(name: "Visa holder"),
                                                         ResidenceStatus(name: "Other")]
}

struct AnnualIncomeArray
{
    static var annualIncomeArray : [AnnualIncome] = [AnnualIncome(name: "Under $50k"),
                                                   AnnualIncome(name: "$50k - $100k"),
                                                   AnnualIncome(name: "$100K - $200k"),
                                                   AnnualIncome(name: "Over $200k")]
}

struct EmploymentStatusArray
{
    static var employmentStatusArray : [EmploymentStatus] = [EmploymentStatus(name: "Employed"),
                                                           EmploymentStatus(name: "Student"),
                                                           EmploymentStatus(name: "Retired"),
                                                           EmploymentStatus(name: "Unemployed")]
}

struct InvestmentArray
{
    static var investmentArray : [Investment] = [Investment(name: "Under $50k"),
                                               Investment(name: "$50k - $100k"),
                                               Investment(name: "$100K - $200k"),
                                               Investment(name: "Over $200k")]
}

struct MaritalStatusArray
{
    static var maritalStatusArray : [String] = ["Single",
                                               "Married",
                                               "Divorced",
                                               "Widow(er)"]
}
