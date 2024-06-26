//
//  CruiserApp.swift
//  Cruiser
//
//  Created by Joshua Watt on 3/26/24.
//

import SwiftUI

@main
struct CruiserApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject var manager = Manager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .onChange(of: scenePhase) { oldValue, newValue in
                    switch newValue {
                    case .background:
                        manager.save()
                    default:
                        break
                    }
                }
        }
    }
}
