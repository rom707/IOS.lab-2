//
//  SecondViewController.swift
//  ForecastMap
//
//  Created by Alshevscky Roman on 04.04.17.
//  Copyright © 2017 Alshevscky Roman. All rights reserved.
//

import UIKit
import GoogleMaps

class SecondViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var cityMarker: GMSMarker! = nil
    var forecastModel = ForecastModel()
    
    
    override func viewDidLoad() {
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.delegate = self
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "ОК", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func chooseCity(name: String) {
        if (cityMarker != nil) {
            cityMarker.map = nil
        }
        let cityInfo = citiesService.getCityByName(name: name)
        if(cityInfo == nil) {
            showMessage(message: "No such city.")
            return
        }
        cityMarker = GMSMarker(position: (cityInfo!.place.coordinate))
        cityMarker.title = cityInfo?.name
        forecastModel.getWeather(city: (cityInfo?.name)!, marker: cityMarker)
        cityMarker.map = mapView
        mapView.selectedMarker = cityMarker
        let camera = GMSCameraPosition.camera(withLatitude: (cityInfo?.place.coordinate.latitude)!,
                                              longitude: (cityInfo?.place.coordinate.longitude)!, zoom: 4)
        mapView.camera = camera
    }}

