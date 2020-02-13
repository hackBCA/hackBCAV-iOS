//
//  MapView.swift
//  hackBCA Schedule
//
//  Created by Anthony Li on 2/12/20.
//  Copyright © 2020 Anthony Li. All rights reserved.
//

import SwiftUI
import MapKit

let bca = CLLocationCoordinate2D(latitude: 40.834380, longitude: -74.181247)

struct MapView: UIViewRepresentable {
    var event: Event
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(MKCoordinateRegion(center: bca, latitudinalMeters: 100, longitudinalMeters: 100), animated: false)
        updateUIView(mapView, context: context)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        if let firstAnnotation = uiView.annotations.first {
            uiView.removeAnnotation(firstAnnotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = bca
        annotation.title = event.name
        annotation.subtitle = event.location
        uiView.addAnnotation(annotation)
    }
}
