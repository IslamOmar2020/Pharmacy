//
//  UIView+Extension.swift
//  Pharmacy
//
//  Created by Islam Omar on 8/23/20.
//  Copyright © 2020 Islam Omar. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
func setRounded() {
      let radius = self.frame.height / 2
      self.layer.cornerRadius = radius//
    self.layer.masksToBounds = true
    }}
