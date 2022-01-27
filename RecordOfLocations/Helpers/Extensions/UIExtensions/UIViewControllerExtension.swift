//
//  UIViewControllerExtension.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import UIKit

extension UIViewController {
    func showOpenSettingsAlert(title:String = APP_NAME, message:String, cancelTitle:String) {
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler:  nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    print("Settings opened: \(success)") // Prints true
                })
            }
        }
        showAlert(title:title, message: message, actions: [cancelAction, settingsAction])
    }
    /**
     Show alert controller from current viewcontroller, with only the cancel button which performs no actions
     
     If you need to perform some action on cancel action, use the method func showAlert(message:String, cancelTitle:String)
     
     - Author:
     Chandrachudh.K
     
     - parameters:
        - message: The message that needs to be displayed
        - cancelTitle: The title of the cancel button
     */
    func showAlert(title:String = APP_NAME, message:String, cancelTitle:String) {
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
        showAlert(title: title, message: message, actions: [cancelAction])
    }
    
    /**
     Show alert controller from current viewcontroller, with all the UIAlertAction buttons provided
     
     You can perfom custom actions for each button this way. Cancel button is not included by default.
     
     - Author:
     Chandrachudh.K
     
     - parameters:
        - message: The message that needs to be displayed
        - actions: The array of action buttons needed in the alert
     */
    func showAlert(title:String = APP_NAME, message:String, actions:[UIAlertAction]) {
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
}
