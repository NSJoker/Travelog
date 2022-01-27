//
//  MainCoordinator.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit
import UserNotifications

class MainCoordinator: Coordinator {
    var navigationContoller: UINavigationController!
    var parentCoordinator: Coordinator?
    
    func start(navigationController: UINavigationController, parent: Coordinator?) {
        self.navigationContoller = navigationController
        self.parentCoordinator = parent
        
        checkPermissions { status in
            if status {
                self.showNextScreen()
            } else {
                DispatchQueue.main.async {
                    let permissionsController = PermissionsController(viewModel: .init(coordinator: self))
                    navigationController.isNavigationBarHidden = true
                    navigationController.pushViewController(permissionsController, animated: false)
                }
            }
        }
    }
    
    func checkPermissions(completionHandler: @escaping ((Bool) -> Void)) {
        if LocationServicesManager.shared.locationManager.authorizationStatus == .authorizedAlways {
            UNUserNotificationCenter.current().getNotificationSettings { (settings) in
                if settings.authorizationStatus == .authorized {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        } else {
            completionHandler(false)
        }
    }
    
    func showNextScreen() {
        print("show table")
        
        DispatchQueue.main.async {
            let visitLogsController = VisitLogsController(viewModel: .init(coordinator: self))
            self.navigationContoller.isNavigationBarHidden = true
            self.navigationContoller.pushViewController(visitLogsController, animated: false)
        }
        
    }
}
