//
//  DictionaryManager.swift
//  AdosFirebaseSocialLogin
//
//  Created by Eduardo de la Cruz on 27/10/17.
//  Copyright © 2017 Eduardo De La Cruz. All rights reserved.
//

import UIKit

class DictionaryManager
{
    static func dictionaryBuider(dict : [String : Any], percent : Int) -> [String : Any]
    {
        var dictionary : [String : Any] = dict
        dictionary["percent"] = percent
        return dictionary
    }
}
