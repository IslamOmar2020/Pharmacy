//
//  DrugDetailsVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/26/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class DrugDetailsVC: UIViewController {
    var drugobject : Drug!
    @IBOutlet weak var drugimage: UIImageView!
    @IBOutlet weak var aoutdrug: UITextView!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        drugimage.sd_setImage(with: URL(string: drugobject.drugImage!), completed: nil)
        name.text = drugobject.drugname
        aoutdrug.text = drugobject.aboutdrug
        count.text = String(drugobject.drugcount!)
    }
    


}
