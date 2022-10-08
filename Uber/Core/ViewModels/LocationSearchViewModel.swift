//
//  LocationSearchViewModel.swift
//  Uber
//
//  Created by Park Junsuk on 2022/10/08.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject {
    @Published var result = [MKLocalSearchCompletion]()
    var selectedLocation: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var queryFragment = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    override init() {
        super.init()
        
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
