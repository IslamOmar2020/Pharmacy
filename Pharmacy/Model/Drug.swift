//
//  Drug.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/24/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
struct Drug: Codable {
// @DoucumentID var id: String? = UUID().uuidString
    var drugname : String?
    //  var drugdate : String?
      var drugImage : String?
    var drugcount : Int?
    var aboutdrug : String?


   
    init(drugname: String,drugcount : Int , aboutdrug : String ,drugImage : String ){
        self.drugname = drugname
       self.drugImage = drugImage
        self.aboutdrug = aboutdrug
        self.drugcount = drugcount
        
    }}
