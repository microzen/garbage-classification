import SwiftUI
import UIKit

struct MapViewControllerWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MapViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else {
            fatalError("Failed to instantiate MapViewController from storyboard")
        }
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        // Update the view controller if necessary
    }
}
