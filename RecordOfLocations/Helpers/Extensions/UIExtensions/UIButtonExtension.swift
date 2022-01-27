//
//  UIButtonExtension.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

extension UIButton {
    
    func customizeForAppTheme() {
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.borderWidth = 1.0
    }
}
