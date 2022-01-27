//
//  NotificationServicesManager.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UserNotifications

class NotificationServicesManager {
    
    static let shared = NotificationServicesManager()
    
    private init() {
    }
    
    func notifiyNewLocationVisit(location:Location) {
        let content = UNMutableNotificationContent()
        content.title = "New Record entry 📌"
        content.body = location.description
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: location.dateString, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
    }
}
