//
//  MapViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 30.04.22.
//

import Foundation
import UIKit
import MapKit

/*
 tutorial: https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started
 */

class MapViewController: UIViewController {
    
    // MARK: - Variables
    
    let IATC_center = TrainingCenter(title: "IATC Center", coordinate: CLLocationCoordinate2D.init(latitude: 40.377020, longitude: 49.851567))
    
    let locationManager = CLLocationManager()
    
    // MARK: - UI Components
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        
        self.view.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Parent delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: self.mapView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.mapView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.mapView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: self.mapView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        ])
        
        let initialLocation = CLLocation.init(latitude: 40.377020, longitude: 49.851567)
        
        let coordinateRegion = MKCoordinateRegion(
              center: initialLocation.coordinate,
              latitudinalMeters: 800,
              longitudinalMeters: 800)
        self.mapView.setRegion(coordinateRegion, animated: true)
        
        self.mapView.addAnnotation(IATC_center)
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        self.IATC_center.coordinate = CLLocationCoordinate2D.init(latitude: 40.377020, longitude: 49.854567)
//    }
    
    // MARK: - Function
    
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let recentLocation = locations.last {
            self.mapView.removeAnnotation(self.IATC_center)
            
            print("location lat \(recentLocation.coordinate.latitude) lon \(recentLocation.coordinate.longitude)")
            self.IATC_center.coordinate = recentLocation.coordinate

            self.mapView.addAnnotation(self.IATC_center)
            
            let coordinateRegion = MKCoordinateRegion(
                center: recentLocation.coordinate,
                latitudinalMeters: 400,
                longitudinalMeters: 400)
            self.mapView.setRegion(coordinateRegion, animated: true)
        }
    }
}

class TrainingCenter: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(title: String?,
         coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    
}
