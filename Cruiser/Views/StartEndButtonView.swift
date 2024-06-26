//
//  StartEndButtonView.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/7/24.
//

import SwiftUI

struct StartEndButtonView: View {
    @EnvironmentObject var manager : Manager
    @Binding var showingAlert : Bool
    
    var body: some View {
        if (!manager.recording && manager.recordedTripIndex == nil){
            Button {
                manager.startNewTrip()
            } label: {
                Text("Start Trip")
                    .padding(10)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
            }
            .buttonStyle(.bordered)
            .tint(.blue)
            .offset(y:320)
        } else if (manager.recordedTripIndex != nil) {
            
        } else {
            InformationOverlaysView()
                .offset(y:200)
                
        }
    }
}

