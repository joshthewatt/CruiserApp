//
//  RecordedInformationOveralysView.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/25/24.
//

import SwiftUI

struct RecordedInformationOveralysView: View {
    @EnvironmentObject var manager : Manager
    
    var body: some View {
        if (manager.recordedTripIndex != nil){
            let trip : trip = manager.trips[manager.recordedTripIndex!]
            VStack(){
                Text("\(trip.name)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text("Date: \(trip.timestamp.formatted())")
            }
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .foregroundColor(.black)
            .background(.white)
            .cornerRadius(10)
            .padding()
            .offset(y:-500)
            VStack{
                HStack{
                    Text("Top Speed: \n\(String(Int(round(trip.maxSpeed * 2.23694)))) mph")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    Text("Distance: \n \(String(format: "%.2f", Float(trip.distance / 1609))) miles")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    }
                HStack{
                    Text("Time: \n \(manager.formatTimeInterval(trip.time))")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                }
                
            }
        }
    }
}

#Preview {
    RecordedInformationOveralysView()
}
