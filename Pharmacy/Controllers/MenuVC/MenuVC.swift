//
//  MenuVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/18/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import LGSideMenuController

class MenuVC: UIViewController {


    @IBOutlet weak var username:UILabel!
    @IBOutlet weak var imageUser:UIImageView!



    @IBOutlet weak var authrizeLogin:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()


      // getDada()
    }

        override func viewDidDisappear(_ animated: Bool) {
        //  getDada()//4
        }
        override func viewWillDisappear(_ animated: Bool) {
      //      getDada()//3
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let mainViewController = sideMenuController!
        sideMenuController?.hideLeftViewAnimated()
    //    getDada()//1 // back1
    }
        override func viewDidAppear(_ animated: Bool) {
          // getDada()//2 // back2
        }
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            performSelector(inBackground: #selector(handleLogout), with: nil)
        }
    }
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()}catch let logoutError {
                print(logoutError)
        }
        }
    
    @IBAction func authrizeAction(){
        if Auth.auth().isSignIn(withEmailLink: "email"){
            print("is login")
        }
        //getDada()
        
        else {
             let vc = self.storyboard!.instantiateViewController(identifier: "LoginCV")
            self.present(vc,animated: true,completion: nil)
        }
    }

    func getIdAction(ide:String) {
        let mainViewController = sideMenuController!
        var viewController: UIViewController!
        let navigationController = mainViewController.rootViewController as! UINavigationController

        viewController = self.storyboard!.instantiateViewController(withIdentifier: ide)

        if navigationController.viewControllers.first is UIViewController  {
            mainViewController.hideLeftViewAnimated()  }
        else {
            viewController = self.storyboard!.instantiateViewController(withIdentifier: ide)
            navigationController.setViewControllers([viewController], animated: false)
            mainViewController.hideLeftView(animated: true, delay: 0.0, completionHandler: nil)
        }

    }




    @IBAction func sideusermenu(_ sender:UIButton){

        switch sender.tag {
        case 0:
            getIdAction(ide:"Home")

            break
        case 1:

            getIdAction(ide:"UserPharmacy")
            break
        case 2:

            getIdAction(ide:"UserDrugs")
            break
        default:
            return
        }

}

}




