//
//  InformationVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/31/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class InformationVC: UIViewController {
    var infoVCobject : Information!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var aboutinfo: UITextView!
    @IBOutlet weak var imageinfo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageinfo.sd_setImage(with: URL(string: infoVCobject.infoimage!), completed: nil)
        titleLbl.text = infoVCobject.infotitle
        aboutinfo.text = infoVCobject.infodetalis

    }
    


}
