//
//  WeatherService.swift
//  WeatherAPP
//
//  Created by Noor Rassam on 2020-12-11.
//

import Foundation

protocol ServiceDelegate {
    func serviceDelegateDidFinishWithData(list : [WeatherJSON])
}

class WeatherService {
    
    static var shared = WeatherService()
    
    var delegate: ServiceDelegate?
    
    func fetchInformation(key: String) {
        if let url = URL(string: "http://gd.geobytes.com/AutoCompleteCity?callback=?&q=\(key)") {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                
                if let data = data {
                    let string = String(data: data, encoding: .utf8)
                    print("Str... ", string!)
                    let dictionary = string?.replacingOccurrences(of: "?(", with: "").replacingOccurrences(of: ");", with: "")
                    print("dictionar... ", dictionary!)
                    if let stringData = dictionary?.data(using: .utf8) {
                        let json = try? JSONSerialization.jsonObject(with: stringData, options: []) as? [String]
                        let decodedData = json?.compactMap({ (string) -> WeatherJSON? in
                            let details = string.split(separator: ",")
                            if(details.count >= 3) {
                                let city = details[0].trimmingCharacters(in: .whitespaces)
                                let state = details[1].trimmingCharacters(in: .whitespaces)
                                let country = details[2].trimmingCharacters(in: .whitespaces)
                                let weatherJson = WeatherJSON(city: city, state: state, country: country)
                                return weatherJson
                            }
                            return nil
                        })
                        self.delegate?.serviceDelegateDidFinishWithData(list: decodedData ?? [])
                    }
                }
            }
            urlSession.resume()
        }
    }
}
