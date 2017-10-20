//
//  Constant.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 22/9/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import Foundation

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
    
    static var currentToken : String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjlkMGNjYjI0NDQ0YzhiMmM5MWYxZGUzODM3MWIxYmJlZTkxZTA4NDZlZmY3YjZkMjg0MzRkMmVmZDFmMDhlZjZmYjNiOGE5OGEyM2IyNzY4In0.eyJhdWQiOiIyIiwianRpIjoiOWQwY2NiMjQ0NDRjOGIyYzkxZjFkZTM4MzcxYjFiYmVlOTFlMDg0NmVmZjdiNmQyODQzNGQyZWZkMWYwOGVmNmZiM2I4YTk4YTIzYjI3NjgiLCJpYXQiOjE1MDg1MjY4NzgsIm5iZiI6MTUwODUyNjg3OCwiZXhwIjoxNTA4NjEzMjc2LCJzdWIiOiIxNzAiLCJzY29wZXMiOltdfQ.qnn_R7DWyjWBARQrcA89azv54DdoyJQ6Y8zHr2ElqB2jyPA7LBbBmeiWB4_Jj-s4Bs6kkFtnSLFILDh5zSfk-0zDRXYucSpXhr-aqUCqJpNtzneyOyuC6Gg8bO8vm85lUC3_faJEABXZEUIytsEYLltPynIu_DOxFmuF4lK47UjTRW8x5I31XeNpkNwZ23e53jmGNnkfTJAyBhDQLmbMOa9osiKcIFT3zNUQIUpqyEPmHW1gXT_DQawcyt8Qri_2Gig0DvG8aa7swzC4YEQ38QqyCBiTCI9xT7Nt8fUJGfN0MLG5k3Vs1FUMMIUtuTy4-DlrWkXaoU9qj7LVK4S_g7FpOUu0BMrRoCGcFyO-spryXUJe9I2R2qbPqxu0wgSUnbHhwzHfcIQMxQ0E_9ieDcY-Wx7h4221z-WCD4Awo-yiyHwsec-2q6RR9QiyN-RuX8y6hPtAaV0o3m1wEcu65EWEeLV-Wn6rYcHm8YhvvYuGMmcRAunBW-YKWmkhweA91RwRhmg3ShDqyzKgUDLw0ZpgX59iqEHvGSx1OpPwlbu0yFOmIS5bYB_qsS35QsQCiiS4A3kaP9zVsb5XXp_G44MgpZjTPu0axDqp_tQwu3L_d6Fh9-WfBWzlGWLGpTp1SZnGNw4vwZ_DMty39MvHI24eiyTLM5mBsdJKP8gArsQ"
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
