//
//  AddDrugVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 7/26/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
class AddDrugVC: UIViewController {

    @IBOutlet weak var drugimage: UIImageView!
    @IBOutlet weak var drugcountTF: UITextField!
    @IBOutlet weak var pharmacynameTF: UITextField!
    @IBOutlet weak var aboutdrugTF: UITextField!
    @IBOutlet weak var drugnameTF: UITextField!
    var users = [User]()
    let ref = Firestore.firestore()
       var parameters = [String:Any]()
//    let query  : QuerySnapshot?
  //  let doucmentid = ref.collection("Pharmacy").id
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func userlist(completion: @escaping (Bool, [User]) -> ()){

//        ref.collection("users").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//                completion(false, users)
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//                completion(true, users)
//            }
//        }
    }
    
    func validateFields() -> String? {
      if drugnameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        drugcountTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || drugnameTF.text?.trimmingCharacters(in:.whitespacesAndNewlines) == "" {
          }
          
          self.showAlertMessage(title: "", message: "Please fill in all fields")
           return "Please fill in all fields"
      }
    @IBAction func adddrugAction(_ sender: Any) {
    //    let doucmentid = ref.
        parameters["aboutdrugTF"] = pharmacynameTF.text!
        parameters["drugcount"] = drugcountTF.text!
        parameters["drugname"] = drugnameTF.text!
        validateFields()
       // parameters["drugimage"] = drugimage.image!
        do{
            let drugsref = self.ref.collection("Drugs")
            try? drugsref.addDocument(data: parameters, completion: { err in
                if let error = err {
                    print(error.localizedDescription)
                    self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                }
                print("sccussfly")
            })
        }
        catch let error {
            self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
        }
    }
}
