//
//  StopWatch.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/8/24.
//

import Foundation

class Stopwatch : ObservableObject {
    @Published var timePassed : TimeInterval = 0
    private var startTime: Date?
    
    func start() {
        self.startTime = Date()
    }
    
    func reset(){
        self.startTime = nil
        self.timePassed = 0
    }
    
    func elapsedTime() -> TimeInterval {
        timePassed = -(self.startTime?.timeIntervalSinceNow ?? 0)
        return timePassed
    }
}
