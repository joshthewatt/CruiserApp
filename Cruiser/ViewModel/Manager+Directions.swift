//
//  Manager+Geocoding.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/26/24.
//

import Foundation
import CoreLocation
import MapKit

extension Manager{
    func forwardGeocoding(address: String) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
                if error != nil {
                    print("Failed to retrieve location")
                    return
                }
                
                var location: CLLocation?
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    let coordinate = location.coordinate
                    self.searchedLocation =  CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
                    self.provideDirections()
                }
                else
                {
                    self.searchedLocation = nil
                }
            })
        }
    func provideDirections() {
        directions = [MKRoute]()
        let destination : MKMapItem = MKMapItem(placemark: MKPlacemark(coordinate: searchedLocation!, addressDictionary: nil))
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = destination
        request.transportType = .walking
        
        let directionsTemp = MKDirections(request: request)
        
        directionsTemp.calculate { response, error in
            guard error == nil else {return}
            if let route = response?.routes.first {
                self.directions.append(route)
            
            }
        }
    }
    func clearDirections(){
        directions = []
        //directionsPolylines = []
    }
}
