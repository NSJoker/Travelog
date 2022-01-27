//
//  LocationServicesManager.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import CoreLocation
import UIKit

class LocationServicesManager: NSObject {
    static let shared = LocationServicesManager()
    
    let geoCoder = CLGeocoder()
    let locationManager = CLLocationManager()
    
    //To create fake visits, set the below param as true. Run the app in  simulator and enable the "Route" gps route start fake walking. We call this setup from appdelegate for generic usage.
    private var isFakeVisit:Bool = false
    
    //Event handlers
    private var autorizationHandler:((Bool) -> Void)?
    
    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAccess(completionHandler: @escaping ((Bool) -> Void)) {
        autorizationHandler = completionHandler
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            completionHandler(true)
            break
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        default:
            guard let appWindow = SceneDelegate.appWindow, let topVC = (appWindow.rootViewController as! UINavigationController).visibleViewController else {
                return
            }
            topVC.showOpenSettingsAlert(message: "To improve the experience, we suggest allowing our app to access your location always or at the least when in use. You can change the authorization in the device settings", cancelTitle: "Cancel")
            break
        }
    }
    
    func startFetchingLocations(isFake:Bool) {
        isFakeVisit = isFake
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.showsBackgroundLocationIndicator = true
        
        if isFake {
            locationManager.distanceFilter = 35
            locationManager.startUpdatingLocation()
        }
    }
    
    func stopFetchingLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.showsBackgroundLocationIndicator = false
    }
    
    private func newVisitReceived(_ visit: CLVisit, description: String) {
        let location = Location(visit: visit, descriptionString: description)
        LocationsStorage.shared.saveLocationOnDisk(location)
        NotificationServicesManager.shared.notifiyNewLocationVisit(location: location)
      }
}


extension LocationServicesManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let autorizationHandler = autorizationHandler else {return}
        switch locationManager.authorizationStatus {
        case .authorizedAlways:
            autorizationHandler(true)
            /*
             Visit monitoring allows you to track destinations — places where the user stops for a while. It wakes the app whenever a new visit is detected and is very energy efficient and not tied to any landmark.
             */
            locationManager.startMonitoringVisits()
            startFetchingLocations(isFake: isFakeVisit)
        default:
            autorizationHandler(false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didVisit visit: CLVisit) {
        // create CLLocation from the coordinates of CLVisit
        let clLocation = CLLocation(latitude: visit.coordinate.latitude, longitude: visit.coordinate.longitude)
        
        // Get location description
        geoCoder.reverseGeocodeLocation(clLocation) { placemarks, _ in
          if let place = placemarks?.first {
            let description = "\(place)"
            self.newVisitReceived(visit, description: description)
          }
        }
    }
    
    //Use only during fake visits
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 1
        guard let location = locations.first, isFakeVisit else {
          return
        }
        
        // 2
        geoCoder.reverseGeocodeLocation(location) { placemarks, _ in
        if let place = placemarks?.first {
          // 3
          let description = "Fake visit: \(place)"
            
          //4
          let fakeVisit = FakeVisit(
            coordinates: location.coordinate,
            arrivalDate: Date(),
            departureDate: Date())
          self.newVisitReceived(fakeVisit, description: description)
        }
      }
    }
}


//Used only for fake visits
final class FakeVisit: CLVisit {
  private let myCoordinates: CLLocationCoordinate2D
  private let myArrivalDate: Date
  private let myDepartureDate: Date

  override var coordinate: CLLocationCoordinate2D {
    return myCoordinates
  }
  
  override var arrivalDate: Date {
    return myArrivalDate
  }
  
  override var departureDate: Date {
    return myDepartureDate
  }
  
  init(coordinates: CLLocationCoordinate2D, arrivalDate: Date, departureDate: Date) {
    myCoordinates = coordinates
    myArrivalDate = arrivalDate
    myDepartureDate = departureDate
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
