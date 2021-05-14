//
//  WeatherModel.swift
//  Weather app
//
//  Created by Mayank Girdhar on 04/06/20.
//
import Foundation

struct WeatherModel {
    let conditionId : Int
    let cityname : String
    let temperature : Double
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 700...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
        
            }
    }
}

