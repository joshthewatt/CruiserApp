//
//  Manager+Motion.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/11/24.
//

import Foundation
import CoreMotion

extension Manager {
    func checkAuthorization() -> Bool {
        let status =  CMMotionActivityManager.authorizationStatus()
        switch status{
        case .authorized:
            return true
        default:
            return false
        }
    }
    
    func startMonitoringMotionActivity() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            print("Motion activity updates not available.")
            return
        }
        
        activityManager.startActivityUpdates(to: motionQueue) { (activity) in
            guard let activity = activity else { return }
            self.handleMotionActivity(activity : activity)
        }
    }
    
    func handleMotionActivity(activity : CMMotionActivity) {
        if (activity.cycling || activity.automotive || activity.running){
            if (!recording && currentTrip == nil){
                startNewTrip()
            }
        }
        
    }
}
    
    

