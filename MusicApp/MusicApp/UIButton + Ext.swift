//
//  UIButton + Ext.swift
//  MusicApp
//
//  Created by MacBook on 03.07.2022.
//

import Foundation
import UIKit

extension UIButton {
    
    func createShadow() {
          self.layer.shadowColor = UIColor(named: "Button_gradient_down")?.cgColor
          self.layer.shadowOffset = CGSize(width: 0, height: 3)
          self.layer.shadowOpacity = 1.0
          self.layer.shadowRadius = 10.0
          self.layer.masksToBounds = true
      }
}
