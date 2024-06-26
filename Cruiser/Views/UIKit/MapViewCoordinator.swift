//
//  MapViewCoordinator.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/1/24.
//

import Foundation
import MapKit

class MapViewCoordinator : NSObject, MKMapViewDelegate {
    let manager : Manager
    
    init(manager: Manager) {
        self.manager = manager
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
      if let routePolyline = overlay as? MKPolyline {
        let renderer = MKPolylineRenderer(polyline: routePolyline)
          if manager.recording{
              if (manager.directionsPolylines.contains(routePolyline)){
                  renderer.strokeColor = UIColor.systemPink
              } else{
                  renderer.strokeColor = UIColor.systemBlue
              }
          } else {
              renderer.strokeColor = UIColor.systemRed
          }
        renderer.lineWidth = 5
        return renderer
      }
      return MKOverlayRenderer()
    }

    //MARK: MapView Delegate
    
    // called when Map needs to display an annotation on the map
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
                // Return nil to use the default annotation view for the user's location
                return nil
            }
            // Custom logic for annotations with specific names
            if let name = annotation.title, name == "start" {
                // Custom view for "start" annotation
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "startAnnotation")
                annotationView.glyphImage = UIImage(systemName: "star.fill")
                annotationView.glyphTintColor = .white
                annotationView.markerTintColor = .green
                return annotationView
            } else if let name = annotation.title, name == "end" {
                // Custom view for "end" annotation
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "endAnnotation")
                annotationView.glyphImage = UIImage(systemName: "flag.checkered")
                annotationView.glyphTintColor = .white
                annotationView.markerTintColor = .red
                return annotationView
            } else {
                // Default view for other annotations
                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "defaultAnnotation") ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "defaultAnnotation")
                // Customize as needed
                return annotationView
            }
    }
//    
//    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
//        return
//    }
    
    
    
 
    // Callout Accessory triggers this function
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {

        
    }
    

    
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        
    }
       
    
    
}
