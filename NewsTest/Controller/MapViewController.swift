//
//  MapViewController.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tuneMapView()
    }
    
    private func tuneMapView() {
        
        let centerCoordinates = CLLocationCoordinate2D(latitude: 48.1351, longitude: 11.5820)
        mapView.setRegion(
            MKCoordinateRegion(
                center: centerCoordinates,
                span: MKCoordinateSpan(
                    latitudeDelta: 20,
                    longitudeDelta: 20
                )
            ),
            animated: true
        )
        
        mapView.delegate = self
        addCustomPins()
    }
    
    private func addCustomPins() {
        let pinArray = CustomAnnotation.makeAnnotations()
        for customPin in pinArray {
            let pin = MKPointAnnotation()
            pin.coordinate = customPin.coordinate
            pin.title = customPin.title
            pin.subtitle = customPin.info
            mapView.addAnnotation(pin)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "CustomPin")
        return annotationView
    }
}
