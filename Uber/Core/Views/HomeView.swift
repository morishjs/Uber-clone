//
//  HomeView.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/07.
//

import SwiftUI

struct HomeView: View {
    @State var showLocationSearchView = false
    @StateObject var viewModel = LocationSearchViewModel()
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapRepresentable()
                .ignoresSafeArea()
                .environmentObject(viewModel)
            
            if showLocationSearchView {
                LocationSearchView(showLocationSearchView: $showLocationSearchView)
                    .environmentObject(viewModel)
            } else {
                LocationSearchActivationView()
                    .padding(.top, 72)
                    .onTapGesture {
                        withAnimation {
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
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
