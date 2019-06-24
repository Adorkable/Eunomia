//
//  Location.swift
//  Tracks->Eunomia
//
//  Created by Ian Grossberg on 8/9/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#endif
import CoreLocation

/// Subscribes to Location Authorization status
public protocol LocationAuthorizationStatusSubscriber: NSObjectProtocol {
    /// Called when authorization status changes
    ///
    /// - Parameters:
    ///   - manager: Location manager
    ///   - status: new status
    func location(_ manager: Location, status: CLAuthorizationStatus)
}

/// Subscribes to location and movement information
public protocol LocationSubscriber: NSObjectProtocol {
    // TODO: protocol methods consistently named

    /// Raw callback information  from iOS location manager
    ///
    /// - Parameters:
    ///   - manager: Location manager instance
    ///   - locations: raw information
    func location(_ manager: Location, locations: [CLLocation])
    /// Called when location changes
    ///
    /// - Parameters:
    ///   - manager: Location manager instance
    ///   - location: new location
    func location(_ manager: Location, location: CLLocation)
    /// Called when heading changes
    ///
    /// - Parameters:
    ///   - manager: Location manager instance
    ///   - didUpdateHeading: Updated heading
    func location(_ manager: Location, didUpdateHeading: CLHeading)
}

// MARK: - Optionals Extension for Swift
public extension LocationSubscriber {
    func location(_ manager: Location, locations: [CLLocation]) {}
    func location(_ manager: Location, location: CLLocation) {}
    func location(_ manager: Location, didUpdateHeading: CLHeading) {}
}

/// Location manager interprets the raw iOS location information into more useful information and notifies any number of subscribers
public class Location: NSObject {
    /// Main instance
    public static let main: Location = Location()
    
    private var locationManager = CLLocationManager() {
        didSet {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.delegate = self
        }
    }
    
    private var _status: CLAuthorizationStatus = .notDetermined
    /// Current location authorization status
    public var status: CLAuthorizationStatus {
        return self._status
    }
    
    private var authorizationStatusSubscribers: [LocationAuthorizationStatusSubscriber] = []
    private var locationSubscribers: [LocationSubscriber] = []
    
    /// Current Location if it has been retrieved
    public var location: CLLocation? {
        return self.locationManager.location
    }

    #if os(iOS)
    /// Current Heading if it has been retrieved
    public var heading: CLHeading? {
        return self.locationManager.heading
    }
    #endif

    /// Set desired accuracy
    public var desiredAccuracy: CLLocationAccuracy {
        get {
            return self.locationManager.desiredAccuracy
        }
        set {
            self.locationManager.desiredAccuracy = newValue
        }
    }

    #if os(iOS)
    /// Set activity type
    public var activityType: CLActivityType {
        get {
            return self.locationManager.activityType
        }
        set {
            self.locationManager.activityType = newValue
        }
    }
    #endif
    
    override public init() {
        self._status = CLLocationManager.authorizationStatus()
        
        super.init()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
    }
}

#if os(iOS)
public extension Location {
    /// Add an authorization subscriber
    ///
    /// - Parameter subscriber: subscriber to add
    func add(subscriber: LocationAuthorizationStatusSubscriber) {
        self.authorizationStatusSubscribers.append(subscriber)
    }
    
    /// Remove an authorization subscriber
    ///
    /// - Parameter subscriber: subscriber to remove
    func remove(subscriber: LocationAuthorizationStatusSubscriber) {
        guard let index = self.authorizationStatusSubscribers.firstIndex(where: { (compare) -> Bool in
            return compare === subscriber
        }) else {
            return
        }
        self.authorizationStatusSubscribers.remove(at: index)
    }

    /// Force ask for "Always Authorizated" location access
    ///
    /// - Returns: `true` if authorization has been requested, `false` otherwise, usually if authorization has already been given or denied
    func askForAlwaysAuthorization() -> Bool {
        switch self._status {
        case .notDetermined:
            self.locationManager.requestAlwaysAuthorization()
            return true

        case .restricted, .denied:
            return false

        case .authorizedWhenInUse, .authorizedAlways:
            return false

        @unknown default:
            // TODO: log
            return false
        }
    }

    /// Force ask for "When In Use Authorizated" location access
    ///
    /// - Returns: `true` if authorization has been requested, `false` otherwise, usually if authorization has already been given or denied
    func askForWhenInUseAuthorization() -> Bool {
        switch self._status {
        case .notDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            return true

        case .restricted, .denied:
            return false

        case .authorizedWhenInUse, .authorizedAlways:
            return false

        @unknown default:
            // TODO: log
            return false
        }
    }
}
#endif

#if os(iOS)
public extension Location {
    /// Show location assistance explanation pop up
    /// Since iOS only allows us requesting authorization one time make sure we don't burn it without explaining the reason for requesting
    /// To localize message add values to keys:
    /// - title: "Enable Location"
    /// - message: "This application requires you to enable Location features on your phone to function.\n\nPlease press Allow when asked to Allow Access"
    ///
    /// - Parameters:
    ///   - over: View controller to show the pop up over
    ///   - animated: Whether to animate the pop up
    ///   - onPresentFinished: Called when presenting the explination is complete
    ///   - onOk: Called when the user presses Ok
    static func showLocationAssistanceExplanationPopup(over: UIViewController, animated: Bool, onPresentFinished: (() -> Void)? = nil, onOk: (() -> Void)? = nil) {
        // TODO: allow for cancel? and/or support built in autodetecting already denied and prompt
        // TODO: direct customizing of title and message
        let alertController = UIAlertController(
            title: NSLocalizedString("Enable Location", comment: "Explanation popup title"),
            message: NSLocalizedString("This application requires you to enable Location features on your phone to function.\n\nPlease press Allow when asked to Allow Access",
                                       comment: "Explanation popup explanation"),
            preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: NSLocalizedString("Ok", comment: "Explanation popup Yes"),
                style: .default,
                handler: { (_) in
                    onOk?()
            })
        )
        
        over.present(alertController, animated: animated, completion: onPresentFinished)
    }
}
#endif

extension Location {
    /// Start tracking location
    public func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    /// Stop tracking location
    public func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }

    public func startUpdatingOnlySignifigantLocationChanges() -> Bool {
        guard !CLLocationManager.significantLocationChangeMonitoringAvailable() else {
            // The service is not available.
            // TODO: switch to exception throw
            return false
        }

        self.locationManager.startMonitoringSignificantLocationChanges()

        return true
    }

    public func stopUpdatingOnlySignifigantLocationChanges() {
        self.locationManager.stopMonitoringSignificantLocationChanges()
    }

    #if os(iOS)
    /// Start tracking heading
    public func startUpdatingHeading() {
        self.locationManager.startUpdatingHeading()
    }
    
    /// Stop tracking heading
    public func stopUpdatingHeading() {
        self.locationManager.stopUpdatingHeading()
    }
    #endif
}

public extension Location {
    /// Add a location and heading subscriber
    ///
    /// - Parameter subscriber: Subscriber to add
    func add(subscriber: LocationSubscriber) {
        self.locationSubscribers.append(subscriber)
    }
    
    /// Remove a location and heading subscriber
    ///
    /// - Parameter subscriber: Subscriber to remove
    func remove(subscriber: LocationSubscriber) {
        guard let index = self.locationSubscribers.firstIndex(where: { (compare) -> Bool in
            return compare === subscriber
        }) else {
            return
        }
        self.locationSubscribers.remove(at: index)
    }
    
    /// Do something for each location and heading subscriber
    ///
    /// - Parameter forEachDo: Closure to do for each subscriber
    /// - Throws: When a closure throws
    func forEach(_ forEachDo: (LocationSubscriber) throws -> Void) rethrows {
        try self.locationSubscribers.forEach(forEachDo)
    }
}

extension Location: CLLocationManagerDelegate {
    /// iOS Location Manager authorization changed, processes and passes to authorization subscribers
    ///
    /// - Parameters:
    ///   - manager: iOS Location Manager
    ///   - status: now authorization status
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self._status = status
        for subscriber in self.authorizationStatusSubscribers {
            subscriber.location(self, status: status)
        }
    }
    
    /// iOS location Manager location changed, processes and passes to location and heading subscribers
    ///
    /// - Parameters:
    ///   - manager: iOS Location manager
    ///   - locations: new locations
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.handle(didUpdate: locations)
    }

    #if os(iOS)
    /// iOS location Manager heading changed, processes and passes to location and heading subscribers
    ///
    /// - Parameters:
    ///   - manager: iOS Location manager
    ///   - locations: new heading
    public func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        self.handle(didUpdate: newHeading)
    }
    #endif
}

extension Location {
    private func handle(didUpdate: [CLLocation]) {
        for subscriber in self.locationSubscribers {
            subscriber.location(self, locations: didUpdate)
            if let location = didUpdate.first {
                subscriber.location(self, location: location)
            }
        }
    }
    
    private func handle(didUpdate: CLHeading) {
        for subscriber in self.locationSubscribers {
            subscriber.location(self, didUpdateHeading: didUpdate)
        }
    }
}

public extension Location {
    static func placemark(from location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location, completionHandler: completionHandler)
    }

    static func placemark(from location: CLLocation, completionHandler: @escaping (CLPlacemark?, Error?) -> Void) {
        self.placemark(from: location) { (placemarks: [CLPlacemark]?, error) in
            let firstLocation = placemarks?.first
            completionHandler(firstLocation, error)
        }
    }
}
