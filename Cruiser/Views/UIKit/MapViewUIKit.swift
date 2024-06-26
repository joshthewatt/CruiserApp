//
//  MapViewUIKit.swift
//  Cruiser
//
//  Created by Joshua Watt on 3/29/24.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewUIKit : UIViewRepresentable {
    @EnvironmentObject var manager : Manager
    //var camera : MKMapCamera
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        //mapView.setUserTrackingMode(.follow, animated: true)
        mapView.showsCompass = false
        mapView.delegate = context.coordinator
        mapView.isScrollEnabled = true
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.removeAnnotations(mapView.annotations)
        if (manager.startAnnotationCoordinate != nil){
            mapView.addAnnotation(manager.getStartAnnotation())
        }
        if (manager.endAnnotationCoordinate != nil) {
            mapView.addAnnotation(manager.getEndAnnotation())
        }
        if(manager.recording && manager.currentTrip != nil){
            if (manager.lastRecordedTripIndex != nil) {
                mapView.removeOverlays(manager.trips[manager.lastRecordedTripIndex!].polylines)
            }
            if (manager.directions.count > 0){
                mapView.addOverlays(manager.directionsPolylines)
            } else{
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.setRegion(manager.region, animated: true)
            mapView.addOverlays(manager.currentTrip?.polylines ?? [])
        } else if (manager.recordedTripIndex != nil && manager.trips.count > 0) {
            mapView.removeOverlays(mapView.overlays)
            mapView.addOverlays(manager.trips[manager.recordedTripIndex!].polylines)
            mapView.setRegion(manager.getRecordedRegion(), animated: true)
        }
        else {
            mapView.removeOverlays(mapView.overlays)
            mapView.setUserTrackingMode(.follow, animated: true)
        }
        return
        
        

    }
    
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(manager: manager)
    }
}
/*
func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView()
  
    return mapView
}


func updateUIView(_ mapView: MKMapView, context: Context) {
    return
}
 */

