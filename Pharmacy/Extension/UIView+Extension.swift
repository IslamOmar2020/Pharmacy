//
//  UIView+Extension.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/23/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
import UIKit
var vSpinner : UIView?
extension UIView {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
    
func setRounded() {
      let radius = self.frame.height / 2
      self.layer.cornerRadius = radius//
    self.layer.masksToBounds = true
    }
    
}
