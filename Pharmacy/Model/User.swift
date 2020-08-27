//
//  User.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/3/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

import Foundation

class User {
    private var id:Int = 0
    private var name:String = ""
    private var password:String = ""
    private var usertype :String = ""


    // Check Information of users
    public static func loginUser(){
    
    let user = Auth.auth().currentUser
    if let user = user {
     
      let uid = user.uid
      let email = user.email
      let photoURL = user.photoURL
      var multiFactorString = "MultiFactor: "
      for info in user.multiFactor.enrolledFactors {
        multiFactorString += info.displayName ?? "[DispayName]"
        multiFactorString += " "
      }
      // ...
    }
}
}
// MARK: - Results
class Results: Codable {
    var name: String?
    let id: Int?
    let token, image, email: String?

    init(name: String?, id: Int?, token: String?, image: String?, email: String?) {
        self.name = name
        self.id = id
        self.token = token
        self.image = image
        self.email = email
    }
}
