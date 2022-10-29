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
    @Published var selectedLocationCoord: CLLocationCoordinate2D?
    
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
    
    func selectLocation(_ location: MKLocalSearchCompletion) {
        locationSearch(forLocalSearchCompletion: location) { resp, error in
            if let error = error {
                print("DEBUG: \(error)")
                return
            }
            
            guard let item = resp?.mapItems.first else { return }
            let coord = item.placemark.coordinate
            
            self.selectedLocationCoord = coord
        }
    }
    
    private func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchResult = MKLocalSearch.Request()
        searchResult.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        
        let search = MKLocalSearch(request: searchResult)
        
        search.start(completionHandler: completion)
    }
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.result = completer.results
    }
}
