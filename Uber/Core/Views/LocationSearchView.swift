//
//  LocationSearchView.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/06.
//

import SwiftUI

struct LocationSearchView: View {
    @State var startLocation = ""
    @Binding var mapViewState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .frame(width: 6, height: 6)
                }
                .padding(.trailing)
                
                VStack {
                    TextField("Current Location", text: $startLocation)
                        .padding(.bottom)
                    TextField("Destination Location", text: $viewModel.queryFragment)
                }
            }
            .padding(.horizontal)
            .padding(.top, 72)
            
            Divider()
                .padding(.vertical)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.result, id: \.self) { i in
                        LocationResultCell(title: i.title, subtitle: i.subtitle)
                            .onTapGesture {
                                viewModel.selectLocation(i)
                                mapViewState = .locationSelected
                            }
                    }
                }
            }
            .padding(.leading)
        }
        .background(.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView(mapViewState: .constant(.noInput))
    }
}
