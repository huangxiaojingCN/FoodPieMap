//
//  MapViewController.swift
//  FoodPie
//
//  Created by ciggo on 4/7/20.
//  Copyright © 2020 ciggo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!

    var restaurant = Restaurant()

    override func viewDidLoad() {
        super.viewDidLoad()

        let geoCoder = CLGeocoder()
        print(restaurant.location)
        geoCoder.geocodeAddressString(restaurant.location) {
            placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let placemarks = placemarks {
                let placemark = placemarks[0]

                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }

        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"

        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }

        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView

        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }

        annotationView?.glyphText = "🤒️"
        annotationView?.markerTintColor = UIColor.orange

        return annotationView
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
