////
////  File.swift
////  wasfa
////
////  Created by osamaaassi on 7/24/20.
////  Copyright © 2020 osamaaassi. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class UserHelper {
//    
//    static func isLogin() -> Bool{
//        return UserHelper.lodeUser() != nil
//    }
//    
//    static func saveUser(user:User)  {
//        let userdefult = UserDefaults.standard
//    
//    }
//    
//    static func lodeUser() -> User?{
//        let userdefult = UserDefaults.standard
//        guard let token = userdefult.string(forKey: "token") else{
//            return nil
//        }
//      
//
//       
//    }
//    
// 
//    }
//    
//    
//    static var userInfo : Results?  {
//        set {
//            guard newValue != nil else {
//                UserDefaults.standard.removeObject(forKey: "CurrentUser");
//                return;
//            }
//            let encodedData = try? PropertyListEncoder().encode(newValue)
//            UserDefaults.standard.set(encodedData, forKey:"CurrentUser")
//            UserDefaults.standard.synchronize();
//        }
//        get {
//            if let data = UserDefaults.standard.value(forKey:"CurrentUser") as? Data {
//                return try? PropertyListDecoder().decode(Results.self, from:data)
//            }
//            return nil
//        }
//    }
//}
