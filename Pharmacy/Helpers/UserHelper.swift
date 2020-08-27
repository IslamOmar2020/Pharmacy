//
//  File.swift
//  wasfa
//
//  Created by osamaaassi on 7/24/20.
//  Copyright © 2020 osamaaassi. All rights reserved.
//

import Foundation
import UIKit

class UserHelper {
    
    static func isLogin() -> Bool{
        return UserHelper.loadUser() != nil
            
    }
    
    static func saveUser(user:User)  {
        let userdefult = UserDefaults.standard
    
    }
    
    static func loadUser() -> User?{
        let userdefult = UserDefaults.standard
        guard let token = userdefult.string(forKey: "token") else{
            return nil
        }

        let name =  userdefult.string(forKey: "name")
        let email = userdefult.string(forKey: "email")
        let image = userdefult.string(forKey: "image")
        let objUser =  Results(name: name, id: 0, token: token, image: image, email: email)
        let user = User()
            return user
       
    }

 
    }

