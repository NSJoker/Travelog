//
//  PermissionsViewModel.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import Foundation
import UserNotifications

protocol PermissionsViewModelDelegate: AnyObject {
    func locationAccessChanged()
    func notificationsAccessChanged()
}

class PermissionsViewModel {
    
    weak var delegate:PermissionsViewModelDelegate?
    
    private let coordinator:MainCoordinator
    
    init(coordinator:MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func getLocationAuth() -> Bool {
        return ((LocationServicesManager.shared.locationManager.authorizationStatus == .authorizedAlways) || (LocationServicesManager.shared.locationManager.authorizationStatus == .authorizedWhenInUse))
    }
    
    func getNotificationAuth(completionHandler: @escaping ((Bool) -> Void)) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            DispatchQueue.main.async {
                if settings.authorizationStatus == .authorized {
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        }
    }
    
    func requestLocationAccess() {
        LocationServicesManager.shared.requestAccess { [weak self] status in
            guard let self = self else {return}
            self.delegate?.locationAccessChanged()
            self.checkBothAccess()
        }
    }
    
    func requestNotificationsAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { [weak self] granted, error in
            guard let self = self else {return}
            self.delegate?.notificationsAccessChanged()
            self.checkBothAccess()
        }
    }
    
    private func checkBothAccess() {
        coordinator.checkPermissions { [weak self] status in
            guard let self = self else {return}
            if status {
                self.coordinator.showVisitLogScreen()
            }
        }
    }
}
