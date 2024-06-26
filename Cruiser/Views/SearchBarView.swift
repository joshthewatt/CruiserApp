//
//  SearchBarView.swift
//  Cruiser
//
//  Created by Joshua Watt on 4/26/24.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var manager : Manager
    @State private var searchText = ""
    @State private var searchIsActive = false
    
    var body: some View {
            Button {
                searchIsActive = true
            } label: {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.title)
            }
            .sheet(isPresented: $searchIsActive){
                    HStack{
                        TextField("Search a location", text: $searchText)
                            .padding([.all], 20)
                            .presentationDetents([.fraction(0.15)])
                            .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                        Image(systemName: "magnifyingglass")
                            .padding([.trailing], 5)
                            .onTapGesture {
                                manager.forwardGeocoding(address: searchText)
                                if (manager.directions.count > 0){
                                    searchIsActive = false
                                }
                            }
                    }
            }
        }
    }
    


#Preview {
    SearchBarView()
        .environmentObject(Manager())
}
