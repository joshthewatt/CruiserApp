//
//  ModelStructs.swift
//  Cruiser
//
//  Created by Joshua Watt on 3/29/24.
//

import Foundation
import MapKit

struct trip : Identifiable {
    var name : String = ""
    var timestamp : Date
    var path : [CLLocationCoordinate2D]
    var distance : CLLocationDistance
    var maxSpeed : CLLocationSpeed = 0
    var polylines : [MKPolyline] = []
    var speedIncrements : [CLLocationSpeed] = []
    var time : TimeInterval = 0
    let initialElevation : CLLocationDistance
    var startCoordinate : CLLocationCoordinate2D
    var endCoordinate : CLLocationCoordinate2D
    let id = UUID()
}

struct tripSaveStruct : Codable {
    let name : String
    let timeStamp : Date
    var path : [Coordinates]
    var distance : Double
    var maxSpeed : Double
    var speedIncrements : [CLLocationSpeed] = []
    var startCoordinate : Coordinates
    var endCoordinate : Coordinates
    var time : TimeInterval
  
}

struct Coordinates : Codable {
    let latitude : Double
    let longitude : Double
}


