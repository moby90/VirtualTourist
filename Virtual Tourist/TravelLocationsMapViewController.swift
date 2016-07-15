//
//  TravelLocationsMapViewController.swift
//  Virtual Tourist
//
//  Created by Moritz Nossek on 11/07/16.
//  Copyright © 2016 Moritz Nossek. All rights reserved.
//

import UIKit
import MapKit

class TravelLocationsMapViewController: UIViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var navigationButtonRight: UIBarButtonItem!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: -
  
    //MARK: View Management
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLongPressGestureRecognizer()
    }
    
    //MARK: -
    
    //MARK: Button Management
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        toggleDeleteView()
    }
    
    private func toggleDeleteView() {
        
        guard let navigationButtonText = navigationButtonRight.title else {
            debugPrint("There is no valid navigation button text available.")
            return
        }
        
        //switch over button text to identify the state
        switch navigationButtonText {
        case "Edit":
            navigationButtonRight.title = "Done"
            deleteView.hidden = false
            break
            
        case "Done":
            navigationButtonRight.title = "Edit"
            deleteView.hidden = true
            break
        default:
            break
        }
    }
    
    //MARK: -
    
    //MARK: MapView Management
    
    private func addLongPressGestureRecognizer() {
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TravelLocationsMapViewController.selectorAddAnnotation))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func selectorAddAnnotation(gestureRecognizer: UIGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            addAnnotation(gestureRecognizer.locationInView(mapView))
            break
        default:
            break
        }
    }
    
    private func addAnnotation(touchPoint: CGPoint) {
        let coordinates = mapView.convertPoint(touchPoint, toCoordinateFromView: mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude), completionHandler: {
            (placemarks, error) -> Void in
            
            guard error == nil else {
                print("Reverse geocoder failed with error" + error?.localizedDescription)
                return
            }
            
            if placemarks?.count > 0 {
                
            }
        })
    }
    
    //MARK: -
    
}
