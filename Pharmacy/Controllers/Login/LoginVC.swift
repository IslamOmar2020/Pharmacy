//
//  LoginVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 7/26/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

import Firebase
import FirebaseFirestore
import FirebaseAuth


class LoginVC: UIViewController {

    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
   var getLoginDetails = [LoginData]()
   var defaults = UserDefaults.standard
   var isVerifyOn = false
     let ref = Firestore.firestore()
    
    override func viewDidAppear(_ animated: Bool) {
        let status = UserDefaults.standard.bool(forKey: "isLogin2")
        if(status == true){
            nextView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Handle Action Button 'login'
    @IBAction func login(_ sender: Any) {
        guard let text = emailTF.text, !text.isEmpty else {
            showMessage(msg: "Email can't be Empty")
            return
        }
        
        guard let text2 = passwordTF.text, !text2.isEmpty else {
            showMessage(msg: "Password can't be Empty")
            return
        }
        
        if Auth.auth().currentUser != nil{
            
            saveUserInDefualt()
            nextView()

        }else{
            
            showMessage(msg: "Username or Password is Wrong")
        }
    }
    
    private func nextView(){
        // Get StoryBoard with name 'Main'
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        // Get Next ViewConroller to allow us to make present to this ViewConroller
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "nextView") as! UINavigationController
        // Show 'nextViewController' after get from storyBoard
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    // Helper Method to make UIAlert is easy
    private func showMessage(msg m:String){
        let alert = UIAlertController(title: "Login Operation", message: m, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Save Status in UserDefaults
    private func saveUserInDefualt(){
        UserDefaults.standard.set(true, forKey: "isLogin2")
    }

 func pharmacy_loginDetails() {

//     UserHandler.loginDetails(success: { (successResponse) in
//         if successResponse.success {
//             UserHandler.sharedInstance.objLoginDetails = successResponse.data
//             self.adForest_populateData()
//         }
//         else {
//             let alert = Constants.showBasicAlert(message: successResponse.message)
//             self.presentVC(alert)
//         }
//
//     }) { (error) in
//         self.stopAnimating()
//         let alert = Constants.showBasicAlert(message: error.message)
//         self.presentVC(alert)
//     }
 }
    
    func isOnlineUser(){
        // need to chek if the user is online
        //Auth.auth().ondi

    }
        
    @IBAction func loginAction() {
        let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email,password: password){
            (result , error) in
            if error != nil {
                print(error!)
            }
            else{

                let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
   @IBAction func createAcountAction(_ sender : Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
        }}
        

