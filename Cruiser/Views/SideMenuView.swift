//
//  SideMenuView.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/10/24.
//

import SwiftUI

struct SideMenuView: View {
        @EnvironmentObject var manager : Manager
        @Binding var isShowing: Bool
        
        func didDismiss(){
            isShowing = false
            
        }
        var body: some View {
            if (!manager.recording){
                Button {
                    isShowing.toggle()
                    manager.recordedTripIndex = nil
                    manager.startAnnotationCoordinate = nil
                    manager.endAnnotationCoordinate = nil
                } label: {
                    Image(systemName: "list.bullet")
                        .foregroundColor(Color(.iconWhite))
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                .sheet(isPresented: $isShowing, onDismiss: {didDismiss()}){
                    VStack{
                        ZStack{
                            Text("Saved Trips")
                                .font(.title)
                                .frame(alignment: .center)
                                .padding()
                            Button("Dismiss"){
                                didDismiss()
                            }
                            .offset(x : 150)
                        }
                        if (!manager.trips.isEmpty){
                            List{
                                ForEach(0..<manager.trips.count, id: \.self) { index in
                                    let trip = manager.trips[index]
                                    TripItem(name: trip.name, timeStamp: trip.timestamp, length: trip.time)
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            manager.recordedTripIndex = index
                                            manager.startAnnotationCoordinate = manager.trips[index].startCoordinate
                                            manager.endAnnotationCoordinate = manager.trips[index].endCoordinate
                                            didDismiss()
                                        }
                                }
                            }
                        } else {
                            HStack{
                                Text("No stored trips")
                            }
                            .presentationDetents([.fraction(0.15)])
                        }
                    }
                }
            }
        }
            }

struct TripItem : View {
    @EnvironmentObject var manager : Manager
    let name : String
    let timeStamp : Date
    let length : TimeInterval
    
    
    var body : some View {
        VStack(alignment: .leading){
            Text("\(name)")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            HStack{
                Text("Date: \(timeStamp.formatted())")
                Text("Time: \(manager.formatTimeInterval(length))")
            }
        }
    }
}

#Preview {
    SideMenuView(isShowing: .constant(true))
        .environmentObject(Manager())
}
