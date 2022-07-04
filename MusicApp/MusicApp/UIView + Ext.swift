//
//  UIView + Ext.swift
//  MusicApp
//
//  Created by MacBook on 03.07.2022.
//

import Foundation
import UIKit

extension UIView {

    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}
