//
//  UIViewController+Extension.swift
//  Pharmacy
//
//  Created by Islam Omar on 7/26/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//
import UIKit
import Foundation

fileprivate var aView : UIView?

extension UIViewController {

    func showAlertMessage(title :String = "", message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert,animated: true,completion: nil)
    }
    
  
}
