
//
//  HomeData.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/29/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//
import Foundation
struct HomeData: Codable {
 var id: String? = UUID().uuidString
    var dataname : String?
      var dataimage : String?
        var datadetalis : String?
     
    init(dataname: String,dataimage : String ,datadetalis :String ){
        self.dataname = dataname
       self.dataimage = dataimage
         self.datadetalis = datadetalis
      
    }}
