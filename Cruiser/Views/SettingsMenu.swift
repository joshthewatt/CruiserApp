//
//  SettingsMenu.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/25/24.
//

import SwiftUI

struct SettingsMenu: View {
    @EnvironmentObject var manager : Manager
    @Binding var isShowing: Bool
    
    func didDismiss(){
        isShowing = false
    }
    var body: some View {
            Button {
                isShowing.toggle()
            } label: {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(Color(.iconWhite))
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            }
            .sheet(isPresented: $isShowing, onDismiss: {didDismiss()}){
                Toggle("Auto Record On", isOn: $manager.autoRecord)
                    .padding()
                    .presentationDetents([.fraction(0.15)])
            }
            
        }
    }
    



