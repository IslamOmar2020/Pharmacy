//
//  LoginRoot.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/11/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
struct LoginRoot{
    
    var data : LoginData!
    var message : String!
    var success : Bool!
    
  
    init(fromDictionary dictionary: [String:Any]){
        if let dataData = dictionary["data"] as? [String:Any]{
            data = LoginData(fromDictionary: dataData)
        }
        message = dictionary["message"] as? String
        success = dictionary["success"] as? Bool
    }
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        if message != nil{
            dictionary["message"] = message
        }
        if success != nil{
            dictionary["success"] = success
        }
        return dictionary
    }
    
}
