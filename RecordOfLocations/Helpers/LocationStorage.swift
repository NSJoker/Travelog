//
//  LocationStorage.swift
//  RecordOfLocations
//
//  Created by Chandrachudh K on 27/01/22.
//

import CoreLocation

//This will be our API communications class
//Instead of core data we are storing the locations in the local file storage. I have done this for the ease of coding and due to limit time.
class LocationsStorage {
  static let shared = LocationsStorage()
  
  private(set) var locations: [Location]
  private let fileManager: FileManager
  private let documentsURL: URL
  
  init() {
    let fileManager = FileManager.default
    documentsURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    self.fileManager = fileManager
    
    let jsonDecoder = JSONDecoder()
    
    let locationFilesURLs = try! fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
    locations = locationFilesURLs.compactMap { url -> Location? in
      guard !url.absoluteString.contains(".DS_Store") else {
        return nil
      }
      guard let data = try? Data(contentsOf: url) else {
        return nil
      }
      return try? jsonDecoder.decode(Location.self, from: data)
    }.sorted(by: { $0.date < $1.date })
  }
  
  func saveLocationOnDisk(_ location: Location) {
    let encoder = JSONEncoder()
    let timestamp = location.date.timeIntervalSince1970
    let fileURL = documentsURL.appendingPathComponent("\(timestamp)")
    
    let data = try! encoder.encode(location)
    try! data.write(to: fileURL)
    
    locations.append(location)
    
    NotificationCenter.default.post(name: .newLocationSaved, object: self, userInfo: ["location": location])
  }
  
  func saveCLLocationToDisk(_ clLocation: CLLocation) {
    let currentDate = Date()
    LocationServicesManager.shared.geoCoder.reverseGeocodeLocation(clLocation) { placemarks, _ in
      if let place = placemarks?.first {
        let location = Location(clLocation.coordinate, date: currentDate, descriptionString: "\(place)")
        self.saveLocationOnDisk(location)
      }
    }
  }
}
