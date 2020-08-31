//
//  CategoryDetails.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/29/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
struct CategoryDetails: Codable {
 var id: String? = UUID().uuidString
    var itemname : String?
      var itemimage : String?
        var itemcount : Int?
         var itemprice : Int?
    init(itemname: String,itemimage : String ,itemcount :Int ,itemprice :Int){
        self.itemname = itemname
       self.itemimage = itemimage
         self.itemcount = itemcount
         self.itemprice = itemprice
        
    }}
