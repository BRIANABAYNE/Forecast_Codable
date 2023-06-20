//
//  Day.swift
//  Forecast_Codable
//
//  Created by Briana Bayne on 6/20/23.
//

import Foundation

struct TopLevelDictonary: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case days = "data"
        
    }
    
    let days: [Day]
    let cityName: String
    
}

struct Day: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        
        case temp
        case highTemp = "high_temp"
        case lowTemp = "low_temp"
        case validDate = "valid_date"
        case weather
    }
    
    let temp: Double
    let highTemp: Double
    let lowTemp: Double
    let validDate: String
    let weather: Weather

}

struct Weather: Decodable {
    private enum CodingKeys: String, CodingKey {
        case description
        case iconString = "icon"
    }
    
    let description: String
    let iconString: String
}
