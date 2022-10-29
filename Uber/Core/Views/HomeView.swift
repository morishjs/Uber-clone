//
//  HomeView.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/07.
//

import SwiftUI

struct HomeView: View {
    @State var mapViewState: MapViewState = .noInput
    @StateObject var viewModel = LocationSearchViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapRepresentable(mapState: $mapViewState)
                .ignoresSafeArea()
                .environmentObject(viewModel)
            
            if mapViewState == .searching {
                LocationSearchView(mapViewState: $mapViewState)
                    .environmentObject(viewModel)
            } else if mapViewState == .noInput {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation {
                            mapViewState = .searching
                        }
                    }
            }
            
            MapViewActionButton(mapViewState: $mapViewState)
                .environmentObject(viewModel)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
