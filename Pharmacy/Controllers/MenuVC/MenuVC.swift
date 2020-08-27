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
      initData()

    }
    func initData(){
        if UserHelper.isLogin(){
        //    let user = UserHelper.loadUser()
       //     username.text = user.
            authrizeLogin.setTitle("Logout", for: .normal)
        } else {
            username.text = "Guest"
            authrizeLogin.setTitle("Login", for: .normal)
        }
    }
        override func viewDidDisappear(_ animated: Bool) {
        //  getDada()//4
        }
        override func viewWillDisappear(_ animated: Bool) {
      //      getDada()//3
        }
  
        override func viewDidAppear(_ animated: Bool) {
          // getDada()//2 // back2
        }
    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            performSelector(inBackground: #selector(handleLogout), with: nil)
        }
    }
    @IBAction func logoutAction(_ sender: Any) {
        handleLogout()
    }
    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()}catch let logoutError {
                print(logoutError)
        }     }
    
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
    @IBAction func CategoriesAction(_ sender: Any) {
         let vc = self.storyboard!.instantiateViewController(identifier: "CategoriesCV")
         self.present(vc,animated: true,completion: nil)
      }

}




