import SwiftUI
import MapKit

struct UberMapRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager()
    @EnvironmentObject var viewModel: LocationSearchViewModel
    @Binding var mapState: MapViewState
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapState {
        case .noInput:
            context.coordinator.clearMapView()
            break
        case .searching:
            break
        case .locationSelected:
            if let coord = viewModel.selectedLocationCoord {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coord)
                context.coordinator.configurePolyline(withDestinationCoord: coord)
            }
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        let parent: UberMapRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        init(parent: UberMapRepresentable) {
            self.parent = parent
            super.init()
        }
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            currentRegion = region
            parent.mapView.setRegion(region, animated: true)
        }
 
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
                let polyline = MKPolylineRenderer(overlay: overlay)
                polyline.strokeColor = .systemBlue
                polyline.lineWidth = 6
                return polyline
        }
        
        func addAndSelectAnnotation(withCoordinate coord: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            
            let anno = MKPointAnnotation()
            anno.coordinate = coord
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestinationCoord coord: CLLocationCoordinate2D) {
            guard let userCoord = self.userLocationCoordinate else { return }
            getDestinationRoute(from: userCoord, dest: coord) { route in
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
                self.parent.mapView.addOverlay(route.polyline)
            }
        }
        
        private func getDestinationRoute(from userLocation: CLLocationCoordinate2D, dest destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void) {
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlacemark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlacemark)
            let directions = MKDirections(request: request)
            
            directions.calculate { resp, error in
                if let error = error {
                    print("DEBUG: Failed to get direction with error: \(error)")
                    return
                }
                
                guard let route = resp?.routes.first else { return }
                completion(route)
            }
        }
        
        func clearMapView() {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays)
            
            if let region = currentRegion {
                parent.mapView.setRegion(region, animated: true)
            }
        }
    }
}
