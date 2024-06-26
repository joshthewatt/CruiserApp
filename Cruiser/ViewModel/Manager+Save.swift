//
//  Manager+Save.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/11/24.
//

import Foundation
import CoreLocation
import MapKit

extension Manager{
    
    func save(){
        let saveData = convertToSave(trips: trips)
        persistence.save(components: saveData)
    }
    
    func convertToSave(trips : [trip]) -> [tripSaveStruct]{
        var save : [tripSaveStruct] = []
        for trip in trips{
            var coordPath : [Coordinates] = []
            for coords in trip.path{
                let point = Coordinates(latitude: coords.latitude, longitude: coords.longitude)
                coordPath.append(point)
            }
            let startTemp = Coordinates(latitude: trip.startCoordinate.latitude, longitude: trip.startCoordinate.longitude)
            let endTemp = Coordinates(latitude: trip.endCoordinate.latitude, longitude: trip.endCoordinate.longitude)
            let temp = tripSaveStruct(name: trip.name, timeStamp: trip.timestamp, path: coordPath, distance: trip.distance, maxSpeed: trip.maxSpeed, speedIncrements: trip.speedIncrements, startCoordinate: startTemp, endCoordinate : endTemp, time: trip.time) // might need to be var
            save.append(temp)
        }
        return save
    }
    
    func convertToUsable(tripData :[tripSaveStruct]) -> [trip]{
        var retVal : [trip] = []
        for tripTemp in tripData {
            var coordPath : [CLLocationCoordinate2D] = []
            for coords in tripTemp.path{
                let point = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
                coordPath.append(point)
            }
            var polylines : [MKPolyline] = []
            for index in 1..<coordPath.count {
                let polyline = MKPolyline(coordinates: [coordPath[index - 1], coordPath[index]], count: 2)
                polylines.append(polyline)
            }
            let startTemp = CLLocationCoordinate2D(latitude: tripTemp.startCoordinate.latitude, longitude: tripTemp.startCoordinate.longitude)
            let endTemp = CLLocationCoordinate2D(latitude: tripTemp.endCoordinate.latitude, longitude: tripTemp.endCoordinate.longitude)
            let newTrip = trip(name: tripTemp.name, timestamp: tripTemp.timeStamp, path: coordPath, distance: CLLocationDistance(tripTemp.distance), maxSpeed: CLLocationSpeed(tripTemp.maxSpeed), polylines: polylines, speedIncrements: tripTemp.speedIncrements, time: tripTemp.time, initialElevation: 0, startCoordinate: startTemp, endCoordinate: endTemp)
            retVal.append(newTrip)
        }
        return retVal
    }
}
