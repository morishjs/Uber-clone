//
//  MapViewActionButton.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/05.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapViewState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        Button {
            withAnimation {
                actionForState(mapViewState)
            }
        } label: {
            Image(systemName: imageNameForState(mapViewState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case.noInput:
            return "line.3.horizontal"
        case .locationSelected, .searching:
            return "arrow.left"
        }
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            mapViewState = .searching
        case .searching, .locationSelected:
            mapViewState = .noInput
            viewModel.selectedLocationCoord = nil
        }
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapViewState: .constant(.noInput))
    }
}
