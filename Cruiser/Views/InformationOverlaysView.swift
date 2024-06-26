//
//  InformationOverlaysView.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/8/24.
//

import SwiftUI

struct InformationOverlaysView: View {
    @EnvironmentObject var manager : Manager
    
    var body: some View {
        VStack{
            HStack{
                Text("Speed: \n\(String(manager.getCurrentSpeedUnits())) mph")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
                
                Text("Distance: \n \(String(format: "%.2f", manager.getCurrentDistanceUnits())) miles")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
            }
            HStack{
                Text("Time: \n \(manager.formatTimeInterval(manager.currentTripTimeElapsed))")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
                Text("Elevation Gain: \n \(String(format: "%.2f", manager.getElevation())) ft")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
            }
            Button {
                manager.endTrip()
                manager.autoRecord = false
                
            } label: {
                Text("End")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black)
            }
            .buttonStyle(.bordered)
            .tint(.red)
            
        }
        
    }
}
