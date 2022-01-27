//
//  UIColorExtension.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

extension UIColor {
    class func rgb(fromHex: Int) -> UIColor {
        return rgba(fromHex: fromHex, alpha: 1.0)
    }
    
    class func rgba(fromHex: Int, alpha: CGFloat) -> UIColor {
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static let shadowColor = UIColor.init(named: "ShadowColor") ?? UIColor.black
}
