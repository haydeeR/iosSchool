//
//  MapViewController.swift
//  MisMapas
//
//  Created by Haydee Rodriguez on 09/11/19.
//  Copyright © 2019 iosSchool. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var place: Place!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("El mapa debe mostrar \(place.name)")
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(place.location) { (placemarks, error) in
            if error == nil {
                for placemark in placemarks! {
                    let annotation = MKPointAnnotation()
                    annotation.title = self.place.name
                    annotation.coordinate = (placemark.location?.coordinate)!
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                }
            } else {
                print("Ha habido un error \(String(describing: error?.localizedDescription))")
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
