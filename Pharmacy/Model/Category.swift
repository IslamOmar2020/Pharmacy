//
//  Category.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/27/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
struct Category: Codable {
// @DoucumentID var id: String? = UUID().uuidString
    var categoryname : String?
    //  var drugdate : String?
      var categoryimage : String?
 
   
    init(categoryname: String,categoryimage : String ){
        self.categoryname = categoryname
       self.categoryimage = categoryimage

        
    }}
