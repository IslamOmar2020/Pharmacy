//
//  AddProviderVC.swift
//  Pharmacy
//
//  Created by Islam Omar on 7/26/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift


class AddProviderVC: UIViewController {
    @IBOutlet weak var providername: UITextField!
    @IBOutlet weak var providerpharmacyname: UITextField!
    var prviderobject = [String: Any]()
    
    @IBAction func addproviderAction(_ sender: Any) {
        do{
            
            prviderobject["age"] = providername.text!
            prviderobject["providerpharmacyname"] = providerpharmacyname.text!
            let a = FirestoreReferenceManager.root

            try a.addDocument(data: prviderobject , completion: { err in
                if let error = err {
                    print(error.localizedDescription)
                    self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
                }
                print("sccussfly")
            })
        }  catch let error {
            self.showAlertMessage(title: "error", message: "\(error.localizedDescription)")
        }


    }}
