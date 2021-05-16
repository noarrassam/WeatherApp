//
//  WeatherManager.swift
//  WeatherAPP
//
//  Created by Noor Rassam on 2020-12-10.
//

import Foundation

protocol ServiceDataDelegate {
    func serviceDelegateDidFinishWithData(list : WeatherData)
}

struct WeatherManager {

        let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
        let weatherAppId = "&appid=eff04efa5709d18068cb132cce23a366&units=metric"

        static var shared = WeatherManager()

        var delegate: ServiceDataDelegate?

        private func parse(weatherData: Data) {
            do {

                let decodedData = try
                JSONDecoder().decode(WeatherData.self, from: weatherData)

                let finalData: WeatherData = decodedData

                self.delegate?.serviceDelegateDidFinishWithData(list: finalData)

                print(finalData)
                print("===================================")
            } catch let error {
                print(error)
            }
        }

        func fetchWeather(cityName: String) {
            var fCityName = cityName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)// trim white space

            if(fCityName .contains(" ")) { //add "+" between 2 words
                fCityName = fCityName.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            }

            if let url = URL(string:"\(weatherURL)&q=\(fCityName)\(weatherAppId)") {
                let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in

                    if let data = data {
                        print(data);
                        self.parse(weatherData: data)
                    }
                }
                urlSession.resume()
            }
      }
}
