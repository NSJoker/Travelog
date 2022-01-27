//
//  UIViewExtension.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

extension UIView {
    /**Adds shadow to the view*/
    func addShadowWith(shadowPath:CGPath, shadowColor:CGColor, shadowOpacity:Float, shadowRadius:CGFloat, shadowOffset:CGSize) {
        layer.masksToBounds = true
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        clipsToBounds = false
        layer.shadowPath = shadowPath
    }
}
