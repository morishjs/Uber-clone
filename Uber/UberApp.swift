//
//  UberApp.swift
//  Uber
//
//  Created by Park Junsuk on 2022/09/24.
//

import SwiftUI

@main
struct UberApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .top) {
                UberMapRepresentable()
                    .ignoresSafeArea()
                
                LocationSearchActivationView()
                    .padding(.top, 72)
                
                MapViewActionButton()
                    .padding(.leading)
                    .padding(.top, 4)
            }
        }
    }
}
