//
//  Manager.swift
//  Cruiser
//
//  Created by Joshua Watt on 3/29/24.
//

import Foundation
import MapKit
import SwiftUI
import CoreMotion

class Manager : NSObject, ObservableObject {
    @Published var trips : [trip] = []
    
    let persistence : StorageManager = StorageManager<[tripSaveStruct]>()
    
    @Published var region = MKCoordinateRegion(center: .stateCollege, span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
    
    let locationManager : CLLocationManager
    
    @Published var userLocation : CLLocation?{
        didSet{
            
            if (recording){
                region.center = userLocation!.coordinate
                currentTrip!.path.append(userLocation!.coordinate)
                currentTrip!.polylines.append(MKPolyline(coordinates: [oldValue!.coordinate, userLocation!.coordinate], count: 2))
                currentTrip!.speedIncrements.append(userSpeed)
                currentTripDistance += userLocation!.distance(from: oldValue!)
            }
        }
    }
    @Published var userSpeed : CLLocationSpeed = 0{
        didSet{
            if (currentTrip != nil){
                if (userSpeed > currentTrip!.maxSpeed){
                    currentTrip!.maxSpeed = userSpeed
                }
            }
            if (currentTrip == nil && !recording && userLocation != nil && autoRecord && getCurrentSpeedUnits() > 10){
                startNewTrip()
            }
        }
    }
    
    @Published var userElevation : CLLocationDistance?
    
    @Published var currentTrip : trip? = nil
    
    @Published var currentTripDistance : CLLocationDistance = 0
    
    @Published var currentTripTimeElapsed : TimeInterval = 0
    
    @Published var recording : Bool = false
    
    @Published var autoRecord : Bool = false
    
    @Published var recordedTripIndex : Int? = nil{
        didSet{
            lastRecordedTripIndex = oldValue
        }
    }
    
    @Published var lastRecordedTripIndex : Int? = nil
    
    @Published var clearMapAnnotations : Bool = false
    
    @Published var stopwatch : Stopwatch = Stopwatch()
    
    @Published var showNameAlert : Bool = false
    
    @Published var startAnnotationCoordinate : CLLocationCoordinate2D? = nil
    
    @Published var endAnnotationCoordinate : CLLocationCoordinate2D? = nil
    
    //Geocoding search
    
    @Published var searchedLocation : CLLocationCoordinate2D? = nil
    
    @Published var directions : [MKRoute] = []
    
    var directionsPolylines : [MKPolyline] {directions.map { $0.polyline }}

    
    override init(){
        locationManager = CLLocationManager()
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        let saved = persistence.tripSaveData
        if (saved != nil){
            self.trips = convertToUsable(tripData: saved!)
        }
        
    }

    func startNewTrip(){
        let startCoordinate : [CLLocationCoordinate2D] = [userLocation!.coordinate]
        if (currentTrip == nil && userLocation != nil && userElevation != nil) {
            let newTrip = trip(timestamp : Date(), path: startCoordinate, distance: 0.0, maxSpeed: 0.0, initialElevation: userElevation!, startCoordinate: userLocation!.coordinate, endCoordinate: userLocation!.coordinate)
            currentTrip = newTrip
            startAnnotationCoordinate = startCoordinate[0]
            endAnnotationCoordinate = nil
            recording = true
            recordedTripIndex = nil
            stopwatch.start()
            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){ timer in
                self.currentTripTimeElapsed = self.stopwatch.elapsedTime()
            }
        }
        
    }
    
    func getCurrentSpeedUnits() -> Int {
        return Int(round(userSpeed * 2.23694))
    }
    
    func getCurrentDistanceUnits() -> Float {
        return Float(currentTripDistance / 1609)
    }
    
    func getElevation() -> Double {
        if (userElevation != nil && currentTrip != nil){
            return (userElevation! - currentTrip!.initialElevation) * 3.28084
        }
        else{
            return 0
        }
    }
    
    func endTrip(){
        if (currentTrip != nil){
            showNameAlert = true
            currentTrip!.time = stopwatch.elapsedTime()
            stopwatch.reset()
            currentTrip!.distance = currentTripDistance
            let count = currentTrip!.path.count - 1
            currentTrip!.endCoordinate = currentTrip!.path[count]
            trips.append(currentTrip!)
            startAnnotationCoordinate = nil
            recording = false
            currentTrip = nil
            currentTripDistance = 0
            // the ui manager will make currentTrip nil
        }
        
    }
    
    func formatTimeInterval(_ timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval / 60)
        let seconds = Int(timeInterval.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func clearRecordedTripIndex(){
        recordedTripIndex = nil
        startAnnotationCoordinate = nil
        endAnnotationCoordinate = nil
    }
    
    // functions called when showing a recorded trip
    
    func getRecordedRegion() -> MKCoordinateRegion {
        let count = trips[recordedTripIndex!].path.count
        let region = MKCoordinateRegion(center: trips[recordedTripIndex!].path[count / 2], latitudinalMeters: trips[recordedTripIndex!].distance + 50, longitudinalMeters: trips[recordedTripIndex!].distance + 100)
        return region
    }
    
    func getStartAnnotation() -> MKPointAnnotation {
        if (startAnnotationCoordinate != nil){
            let startpin = MKPointAnnotation()
            startpin.title = "start"
            startpin.coordinate = startAnnotationCoordinate!
            return startpin
        }
        return MKPointAnnotation()
    }
    
    func getEndAnnotation() -> MKPointAnnotation {
        if (endAnnotationCoordinate != nil){
            let endpin = MKPointAnnotation()
            endpin.title = "end"
            endpin.coordinate = endAnnotationCoordinate!
            return endpin
        }
        return MKPointAnnotation()
    }
    
    
}

extension CLLocationCoordinate2D {
    static let stateCollege = CLLocationCoordinate2D(latitude: 40.79550030, longitude: -77.85900170)
}
