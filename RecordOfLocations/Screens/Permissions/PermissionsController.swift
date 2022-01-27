//
//  PermissionsController.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit


class PermissionsController: UIViewController {

    //MARK: Public Properties
    
    //MARK: UI Elements
    @IBOutlet weak var btnLocationAccess: UIButton!
    @IBOutlet weak var btnNotificationAccess: UIButton!
    
    //MARK: Layout Constraints
    
    //MARK: Private Properties
    private var viewModel:PermissionsViewModel!
    
    //MARK: Overidable Properties and Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Public Methods
    convenience init(viewModel:PermissionsViewModel) {
        self.init()
        self.viewModel = viewModel
        self.viewModel.delegate = self
    }
    
    //MARK: Private methods
    private func setupUI() {
        btnLocationAccess.customizeForAppTheme()
        btnNotificationAccess.customizeForAppTheme()
        
        locationAccessChanged()
        btnNotificationAccess.superview?.isHidden = true
        notificationsAccessChanged()
    }
    
    //MARK: Target Methods
    @IBAction func didTapLocationAccessButton(_ sender: Any) {
        viewModel.requestLocationAccess()
    }
    
    @IBAction func didTapUserNotificationButton(_ sender: Any) {
        viewModel.requestNotificationsAccess()
    }
}


extension PermissionsController: PermissionsViewModelDelegate {
    func locationAccessChanged() {
        btnLocationAccess.superview?.isHidden = viewModel.getLocationAuth()
    }
    
    func notificationsAccessChanged() {
        viewModel.getNotificationAuth { status in
            self.btnNotificationAccess.superview?.isHidden = status
        }
    }
}
