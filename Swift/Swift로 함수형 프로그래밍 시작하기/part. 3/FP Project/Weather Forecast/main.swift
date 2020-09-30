//
//  main.swift
//  Weather Forecast
//
//  Created by 박은비 on 2020/09/30.
//  Copyright © 2020 박은비. All rights reserved.
//

import Foundation

struct Location: Codable {
    let title: String
    let location_type: String
    let woeid: Int
    let latt_long: String
}

struct WeatherInfo: Codable {
    let consolidated_weather: [Weather]
}

struct Weather: Codable {
    let weather_state_name: String
    let wind_direction_compass: String
    let applicable_date: String
    let min_temp: Float
    let max_temp: Float
    let the_temp: Float
    let wind_speed: Float
    let wind_direction: Float
    let air_pressure: Float
    let humidity: Float
    let visibility: Float
    let predictability: Float
}

let query = "seoul"
let locQueryUrl = URL(string: "https://www.metaweather.com/api/location/search?query=\(query)")!

// URL로 REST API 요청
if let locData = try? Data(contentsOf: locQueryUrl) {
    
    // JSON 디코딩
    if let locations = try? JSONDecoder().decode([Location].self, from: locData) {

        for location in locations {
            print("[\(location.title)]")

            let woeid = location.woeid
            let weatherUrl = URL(string: "https://www.metaweather.com/api/location/\(woeid)")!
            // 위치를 받아와 좌표를 계산하여 URL를. 만듬
            
            
            // URL로 REST API 요청
            if let weatherData = try? Data(contentsOf: weatherUrl) {
                
                // JSON 디코딩
                if let weatherInfo = try? JSONDecoder().decode(WeatherInfo.self, from: weatherData) {

                    let weathers = weatherInfo.consolidated_weather
                    for weather in weathers {
                        // 데이터 핸들링
                        let state = weather.weather_state_name.padding(toLength: 15,
                                                                       withPad: " ",
                                                                       startingAt: 0)
                        
                        
                        let forecast = String(format: "%@: %@ %2.2f°C ~ %2.2f°C",
                                              weather.applicable_date,
                                              state,
                                              weather.max_temp,
                                              weather.min_temp)
                        print(forecast)
                    }
                }
            }

            print("")
        }
    }
}
