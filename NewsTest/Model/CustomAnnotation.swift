//
//  CustomAnnotation.swift
//  NewsTest
//
//  Created by Konstantin Bolgar-Danchenko on 16.02.2023.
//

import MapKit

final class CustomAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        
        super.init()
    }
}

extension CustomAnnotation {
    
    static func makeAnnotations() -> [CustomAnnotation] {
        return [
            .init(title: "Florence", coordinate: CLLocationCoordinate2D(latitude: 43.769562, longitude: 11.255814), info: "Italy"),
            .init(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.902782, longitude: 12.496366), info: "Italy"),
            .init(title: "Berlin", coordinate: CLLocationCoordinate2D(latitude: 52.520008, longitude: 13.404954), info: "Germany"),
            .init(title: "Luxembourg", coordinate: CLLocationCoordinate2D(latitude: 49.611622, longitude: 6.131935), info: "Luxembourg"),
            .init(title: "Zurich", coordinate: CLLocationCoordinate2D(latitude: 47.373878, longitude: 8.545094), info: "Switzerland"),
        ]
    }
}
