//
//  AddPharmacyTVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/17/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class AddPharmacyTVC: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var pharmacyimage: UIImageView!
    @IBOutlet weak var adressLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
