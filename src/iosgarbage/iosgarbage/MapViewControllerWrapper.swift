import SwiftUI
import UIKit

struct MapViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MapViewController {
        // Assuming MapViewController is designed in the storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "MapViewController") as! MapViewController
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        // Handle updates to the ViewController, if necessary
    }
}
