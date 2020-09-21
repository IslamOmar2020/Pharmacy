//
//  ShowDrugsTVCell.swift
//  Pharmacy
//
//  Created by Islam Omar on 9/11/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class ShowDrugsTVCell: UITableViewCell {

    @IBOutlet weak var imagedrug: UIImageView!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
