//
//  Pharmacy.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/6/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation


struct Pharmacy: Codable {
 // @DoucumentID var id: String? = UUID().uuidString
     var pharmacyname : String?
       var pharmacyaddress : String?
       var pharmacyImage : String?
    
    init(pharmacyname: String,pharmacyaddress :String,pharmacyImage : String ){
        self.pharmacyname = pharmacyname
        self.pharmacyaddress = pharmacyaddress
        self.pharmacyImage = pharmacyImage
     
          
           
       }
 
}
