//
//  ContentView.swift
//  Cruiser
//
//  Created by Joshua Watt on 3/26/24.
//

import SwiftUI
import MapKit 

struct ContentView: View {
    @EnvironmentObject var manager : Manager
    @State var showSideMenu : Bool = false
    @State var showSettingsMenu : Bool = false
    @State var showSearchBar : Bool = false
    @State private var name = ""
    var startUp : Bool = true
    func submit() {
        manager.trips[manager.trips.count - 1].name = name
        name = ""
    }
    var body: some View {
        ZStack{
            
            MapViewUIKit()
                .ignoresSafeArea()
            StartEndButtonView(showingAlert: $manager.showNameAlert)
            SideMenuView(isShowing: $showSideMenu)
                .offset(x:-170, y:-350)
            SettingsMenu(isShowing : $showSettingsMenu)
                .offset(x:170, y:-350)
            if (manager.recording && manager.currentTrip != nil){
                SearchBarView()
                    .offset(x:-170, y:-350)
                if (manager.directions.count > 0){
                    ClearDirectionsView()
                        .offset(y:-350)
                }
            }
            if (manager.recordedTripIndex != nil){
                ClearTripButton()
                    .offset(x:150, y:-350)
                RecordedInformationOveralysView()
                    .offset(y:250)
            }
        }
        .alert("Trip Title", isPresented: $manager.showNameAlert) {
            TextField("Title", text: $name)
            Button("OK", action: submit)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Manager())
}
