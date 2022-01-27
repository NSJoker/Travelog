//
//  VisitLogCell.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

class VisitLogCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblLocationDescription: UILabel!
    @IBOutlet weak var lblLocationId: UILabel!
    @IBOutlet weak var lblLocationDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        baseView.layer.cornerRadius = 8.0
    }
    
    func populateWith(location:Location, index:Int) {
        lblLocationDescription.text = location.description
        lblLocationDate.text = location.dateString
        lblLocationId.text = "#\(index)"
        layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseView.addShadowWith(shadowPath: UIBezierPath(roundedRect: baseView.bounds,
                                                        cornerRadius: 8.0).cgPath,
                               shadowColor: UIColor.shadowColor.withAlphaComponent(0.5).cgColor,
                               shadowOpacity: 1.0,
                               shadowRadius: 3.0,
                               shadowOffset: .zero)
    }
    
}


extension UITableViewCell {
    /// Generated cell identifier derived from class name
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
