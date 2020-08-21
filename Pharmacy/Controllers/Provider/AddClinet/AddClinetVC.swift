//
//  AddClinetVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 7/26/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit

class AddClinetVC: UIViewController {
    var clients = [Client]()
    
    @IBOutlet weak var addclientTV: UITableView!
 @IBOutlet weak var clientnameTF: UITextField!
     @IBOutlet weak var clientadressTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addClientAction() {
//        do{
//            let ref = FirestoreReferenceManager.root.document()
//               let documentid = ref.documentID
//             let userparameters: [String:Any] = ["name":clientnameTF.text!,"adress": clientadressTF.text!,"uid": documentid]
//            FirestoreReferenceManager.root.addDocument(data: userparameters)
//   //         let ref = try //FirestoreReferenceManager.root.collection(FirebaseKeys.CollectionPath.users).document()
                  
                
                  
//            FirestoreReferenceManager.referenveForUserPublicData(uid: documentid) .setData(userparameters, merge: true)
//                           {(error) in
//                               if let error = error {
//                           print(error.localizedDescription)}
//                                print("Successfully set new user data")
//                   }
//
//               }catch let err{
//                   print(err)
//               }
//    }
    
        }}

    
    extension AddClinetVC : UITableViewDataSource , UITableViewDelegate {
        
        func initltable(){
           // addclientTV.dataSource = self
      //      addclientTV.delegate = self
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return clients.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "")
            let client = clients[indexPath.row]
            //cell.textLabel?.text = client.firstname
      //      cell.textLabel?.text = client.lastname
            return cell
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            }
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            guard editingStyle == .delete else {return}
        }
}
