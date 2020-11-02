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

// 비동기로 Data가 있을때만 값을 가져올 수 있게 수정.
func getData(_ url: URL,_ completed: (Data) -> () ){
    if let data = try? Data(contentsOf: url) {
        completed(data)
    }
}
 
// 지역 검색 -> [Location]
func getLocation(query: String,
                 complted: @escaping ([Location]) -> Void) {
    guard let url = URL(string: "https://www.metaweather.com/api/location/search?query=\(query)") else { return }
    
    // 스위프트 문법 상 마지막 클로저는 밖으로 꺼낼수 있다.
    getData(url) { (data) in
        if let location = try? JSONDecoder().decode([Location].self, from: data) {
            complted(location)
        }
    }
}

// 날씨 정보: Location-> woeid -> [Weather]
func getWeathers(woeid: Int,
                complted: @escaping ([Weather]) -> Void ){
    guard let url = URL(string: "https://www.metaweather.com/api/location/\(woeid)") else { return  }
    
    getData(url) { (data) in
        if let location = try? JSONDecoder().decode(WeatherInfo.self, from: data) {
            complted(location.consolidated_weather)
        }
    }
}

func printWeather(_ weather: Weather) {
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

 

 
getLocation(query: "seoul") { (locations) in
    locations.forEach { (location) in
        getWeathers(woeid: location.woeid) { (weathers) in
            print("\(location.title)")
            weathers.forEach { (weather) in
                print(weather)
            }
        }
    }
}
