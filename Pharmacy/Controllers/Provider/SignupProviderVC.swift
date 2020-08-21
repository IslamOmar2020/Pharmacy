//
//  SignupProviderVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/3/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
class SignupProviderVC: UIViewController {
    @IBOutlet weak var pharmacynameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var providernameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpelements()
        
    }
    func setUpelements(){
        Utilities.styleTextField(pharmacynameTF)
        Utilities.styleTextField(passwordTF)
        Utilities.styleTextField(providernameTF)
        Utilities.styleTextField(emailTF)
    }
    func validateFields() -> String? {
    
        if pharmacynameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            providernameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        let cleanPassword = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(cleanPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number "
        }
        //check email here???
        return nil
    }
       
    @IBAction func createAcountAction(_ sender: Any) {
        //validate the fields
        let error = validateFields()
        if error != nil {
            print(error!)
        }else {
            let firstname = pharmacynameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastname = providernameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
              //Create the user
            Auth.auth().createUser(withEmail: email, password: password  ){(result,err) in
                if let err = err {
                    print(err)
                }
                else {
                    let db = Firestore.firestore()
                      db.collection("users").document("Client").setData(["firstname" :firstname ,"lastname" :lastname, "uid": result!.user.uid]){(error) in
                        if error != nil {
                            print(error!)
                        }
                    }
                      // Transition to home screen
                    let vc = self.storyboard?.instantiateViewController(identifier: "HomeVC") as! HomeVC
                    self.present(vc,animated: true)
                }
            }
        }
      
      
    }
}
