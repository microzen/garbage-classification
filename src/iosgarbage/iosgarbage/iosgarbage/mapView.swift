import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        setupMapView()
        geocodeAddressString("UC Davis U Center")
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true // Optional: to show the user's current location
    }

    func geocodeAddressString(_ addressString: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error)")
                return
            }
            guard let location = placemarks?.first?.location else {
                print("No location found")
                return
            }
            self?.searchNearbyFoodBanks(location.coordinate)
        }
    }

    func searchNearbyFoodBanks(_ coordinate: CLLocationCoordinate2D) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "food bank"
        request.region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)

        let search = MKLocalSearch(request: request)
        search.start { [weak self] (response, error) in
            guard let self = self, let response = response else {
                print("Search error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            response.mapItems.forEach { self.addAnnotation($0.placemark) }
        }
    }

    func addAnnotation(_ placemark: MKPlacemark) {
        let annotation = MKPointAnnotation()
        annotation.title = placemark.name
        annotation.coordinate = placemark.coordinate
        mapView.addAnnotation(annotation)
    }
}
