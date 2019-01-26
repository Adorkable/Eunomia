//
//  CLLocation+Utility.swift
//  Eunomia
//
//  Created by Ian Grossberg on 8/24/18.
//  Copyright © 2018 Adorkable. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    public convenience init(latitude: Measurement<UnitAngle>, longitude: Measurement<UnitAngle>) {
        self.init(latitude: CLLocationDegrees(from: latitude), longitude: CLLocationDegrees(from: longitude))
    }
    
    public convenience init(coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

extension CLLocation {
    public func closest(from: [CLLocation]) -> CLLocation? {
        var result: CLLocation? = nil
        var closestDistance: CLLocationDistance = CLLocationDistance.infinity
        
        for testLocation in from {
            let testDistance = self.distance(from: testLocation)
            if result == nil || testDistance < closestDistance {
                result = testLocation
                closestDistance = testDistance
            }
        }
        
        return result
    }
}

extension CLLocation {
    public func heading(to: CLLocation) -> Measurement<UnitAngle> {
        return self.coordinate.heading(to: to.coordinate)
    }
    
    public func heading(to: CLLocation) -> CLLocationDirection {
        return self.coordinate.heading(to: to.coordinate)
    }
}

extension CLLocation: Encodable {
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case altitude
        case horizontalAccuracy
        case verticalAccuracy
        case speed
        case course
        case timestamp
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
        try container.encode(altitude, forKey: .altitude)
        try container.encode(horizontalAccuracy, forKey: .horizontalAccuracy)
        try container.encode(verticalAccuracy, forKey: .verticalAccuracy)
        try container.encode(speed, forKey: .speed)
        try container.encode(course, forKey: .course)
        try container.encode(timestamp, forKey: .timestamp)
    }
}

// Based on https://medium.com/@kf99916/codable-nsmanagedobject-and-cllocation-in-swift-4-b32f042cb7d3
public struct CodableLocation: Codable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let altitude: CLLocationDistance
    let horizontalAccuracy: CLLocationAccuracy
    let verticalAccuracy: CLLocationAccuracy
    let speed: CLLocationSpeed
    let course: CLLocationDirection
    let timestamp: Date

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }

    init(latitude: CLLocationDegrees,
         longitude: CLLocationDegrees,
         altitude: CLLocationDistance,
         horizontalAccuracy: CLLocationAccuracy,
         verticalAccuracy: CLLocationAccuracy,
         speed: CLLocationSpeed,
         course: CLLocationDirection,
         timestamp: Date) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.horizontalAccuracy = horizontalAccuracy
        self.verticalAccuracy = verticalAccuracy
        self.speed = speed
        self.course = course
        self.timestamp = timestamp
    }

    public init(from: CLLocation) {
        self.init(latitude: from.coordinate.latitude, longitude: from.coordinate.longitude, altitude: from.altitude, horizontalAccuracy: from.horizontalAccuracy, verticalAccuracy: from.verticalAccuracy, speed: from.speed, course: from.course, timestamp: from.timestamp)
    }
}

extension CLLocation {
    public convenience init(model: CodableLocation) {
        self.init(coordinate: model.coordinate, altitude: model.altitude, horizontalAccuracy: model.horizontalAccuracy, verticalAccuracy: model.verticalAccuracy, course: model.course, speed: model.speed, timestamp: model.timestamp)
    }
}

//
//extension CLLocation: Decodable {
//    enum CodingKeys: String, CodingKey {
//        case latitude = "latitude"
//        case longitude = "longitude"
//    }
//    public convenience init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CLLocation.CodingKeys.self)
//        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
//        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
//
//        self.init(latitude: latitude, longitude: longitude)
//    }
//}
