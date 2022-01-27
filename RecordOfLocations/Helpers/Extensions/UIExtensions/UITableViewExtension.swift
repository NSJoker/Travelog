//
//  UITableViewExtension.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

extension UITableView {
    /**
     A function that will register the correnponding cell's nib to the tableview.
     
     The parameter nibName will be defaulted as reuseidentifier. Only will work for tableviewcells made with .xib files
     
     - Author:
     Chandrachudh.K
     
     - parameters:
        - nibName: The name of the nib file
     */
    func registerCellWith(nibName:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: nibName)
    }
    
    func registerHeaderViewWith(nibName:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: nibName)
    }
}
