//
//  File.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/5/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation

struct Information: Codable {
   var infotitle : String?
     var infoimage : String?
       var infodetalis : String?
    
   init(infotitle: String,infoimage : String ,infodetalis :String ){
       self.infotitle = infotitle
      self.infoimage = infoimage
        self.infodetalis = infodetalis
     
   }
}
