//
//  ClearTripButton.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/18/24.
//

import SwiftUI

struct ClearTripButton: View {
    @EnvironmentObject var manager : Manager
    var body: some View {
        Button{
            manager.clearRecordedTripIndex()
        } label: {
            Text("Clear")
                .padding()
                .background(Color(red: 1, green: 1, blue: 1))
                .clipShape(Capsule())
                .foregroundColor(.black)
        }
    }
}

#Preview {
    ClearTripButton()
}
