//
//  ClearDirectionsView.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/27/24.
//

import SwiftUI

struct ClearDirectionsView: View {
    @EnvironmentObject var manager : Manager
    var body: some View {
        Button{
            manager.clearDirections()
        } label: {
            Text("Clear Directions")
                .padding()
                .background(Color(red: 1, green: 1, blue: 1))
                .clipShape(Capsule())
                .foregroundColor(.black)
        }
    }
}

#Preview {
    ClearDirectionsView()
}
