//
//  Home.swift
//  Pharmacy
//
//  Created by Islam Omar on 7/23/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import ImageSlideshow
class HomeVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var sginupBtn: UIButton!
    @IBOutlet weak var imageSlider: ImageSlideshow!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpelements()
    
    }
    func setUpelements(){
    Utilities.styleFilledButton(sginupBtn)
         Utilities.styleFilledButton(loginBtn)
     }

    @IBAction func sidemenueAction(_ sender: Any) {
        let sidemenu = self.storyboard!.instantiateViewController(withIdentifier: "MenuVC")
        self.navigationController?.pushViewController(sidemenu, animated: true)
    }
    @IBAction func toaddpharmactpage(_ sender: Any) {
        let addpharmacyvc = self.storyboard!.instantiateViewController(withIdentifier: "AddPharmacyVC")
               self.navigationController?.pushViewController(addpharmacyvc, animated: true)
    }
    @IBAction func signupAction() {
        let createAcountVC = self.storyboard!.instantiateViewController(withIdentifier: "SignupVC")
        self.navigationController?.pushViewController(createAcountVC, animated: true)
    }
    
    @IBAction func loginAction() {
        let loginVC = self.storyboard!.instantiateViewController(withIdentifier: "LoginVC")
             self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
}
