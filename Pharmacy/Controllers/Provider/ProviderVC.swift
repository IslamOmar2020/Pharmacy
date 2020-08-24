//
//  ProviderVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/19/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class ProviderVC: UIViewController {

    @IBOutlet weak var providercollectioview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showClientAction(_ sender: Any) {
    }
    
    @IBAction func addpharmacyAction(_ sender: Any) {
        
          let vc = storyboard?.instantiateViewController(identifier: "AddPharmacyVC") as! AddPharmacyVC
            self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
