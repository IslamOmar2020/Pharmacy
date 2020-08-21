//
//  AlertService.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/6/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
import UIKit
class AlertService {
    private init(){}
    static func addPharmacy (in vc: UIViewController, completion: @escaping (Client) -> Void){
        let alert = UIAlertController(title: "Add User", message: nil, preferredStyle: .alert)
        alert.addTextField {(nameTF) in
            nameTF.placeholder = "Enter the name"
        }
        alert.addTextField{ (pharmacyname) in
            pharmacyname.placeholder = "Enter pharmacy Name"
        
    }
    let add = UIAlertAction(title: "Add", style: .default) { _ in
        guard
            let firstname = alert.textFields?.first?.text,
            let lastname = alert.textFields?.last?.text
            else {return}
        print(lastname)
        print(firstname)
        let client = Client()
        completion(client)
    }
        alert.addAction(add)
        vc.present(alert,animated: true)
}
    static func updateUser(in vc: UIViewController, completion: @escaping () -> Void){
        let alert = UIAlertController(title: "Update User", message: nil, preferredStyle: .alert)
        alert.addTextField{ (pharmacyname) in
                pharmacyname.placeholder = "Enter pharmacy Name"
            
        }
        let update = UIAlertAction(title: "Update", style: .default) { _ in
            guard
                let pharmacyname = alert.textFields?.first?.text,
                let providername = alert.textFields?.last?.text
                else {return}
            print(pharmacyname)
            print(providername)
        }
            alert.addAction(update)
            vc.present(alert,animated: true)
    }
}
