//
//  ForecastModel.swift
//  ForecastMap
//
//  Created by Alshevscky Roman on 04.04.17.
//  Copyright © 2017 Alshevscky Roman. All rights reserved.
//

import Alamofire
import SwiftyJSON
import GoogleMaps

import Foundation


class ForecastModel {
    var API = Config.API
    
    func getCityForecast(city: String, marker: GMSMarker){
        let query = "\(API)\(city)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        Alamofire.request(query!).responseJSON{ response in
         
            let json = JSON(data: response.data!)
            var weatherText = "Temperature: \(json["main"]["temp"]) C\n"
            weatherText += "Humidity: \(json["main"]["humidity"]) %\n"
            weatherText += "Pressure: \(json["main"]["pressure"])"
            marker.snippet = weatherText
        }
        
    }
}
