//
//  PharmacyHomeCVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/29/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class PharmacyHomeCVC: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        
    }
}
