//
//  Provider.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/6/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
struct Provider: Codable {
    var providername : String?
    var providerid: String?
    var providepharmacyname: String?
     var providerphone: Int?
    
    
    init(providername: String,providepharmacyname :String,providerphone :Int,providerid:String ){
        self.providername = providername
        self.providerid = providerid
        self.providerphone = providerphone
        self.providepharmacyname = providepharmacyname
       
        
    }
}
