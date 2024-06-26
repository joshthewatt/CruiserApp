//
//  NameAlertView.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/10/24.
//

import SwiftUI

struct NameAlertView: View {
    @EnvironmentObject var manager : Manager
    @Binding var showingAlert : Bool
    @State private var name = ""

        var body: some View {
            Button("Enter name") {
                showingAlert.toggle()
            }
            .alert("Trip Title", isPresented: $showingAlert) {
                TextField("Title", text: $name)
                Button("OK", action: submit)
            }
        }

        func submit() {
            print("You entered \(name)")
        }
}

#Preview {
    NameAlertView(showingAlert: .constant(true))
}
