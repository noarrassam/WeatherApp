//
//  DetailsViewController.swift
//  WeatherAPP
//
//  Created by Noor Rassam on 2020-12-12.
//

import UIKit

class DetailsViewController: UIViewController, ServiceDataDelegate {
//    var data: WeatherJSON = WeatherJSON(city: "", state: "", country: "")
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var Humidity: UILabel!
    
    @IBOutlet weak var city: UILabel!
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var feelsLikeLbl: UILabel!
    @IBOutlet weak var HumidityLbl: UILabel!
    
    var country: Country? = nil

    func serviceDelegateDidFinishWithData(list: WeatherData) {
        let temp1 = list.main.temp
        //let humidity = list.main.humidity
        let city = list.name
        print("temp is \(temp1)")
        
        let weatherIcon = list.weather[0].icon
       
            DispatchQueue.global().async {
                var imageData: Data!
                if(!weatherIcon.isEmpty) {
                let url = URL(string: "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png")
                imageData = try? Data(contentsOf: url!)
            }
            
            DispatchQueue.main.async { [self] in
                self.title = city
                self.temp.text = "Temp \(temp1.description)"
                //self.Humidity.text = "Humidity \(humidity.description)"
                if(imageData != nil) {
                    self.weatherIconImageView.image = UIImage(data: imageData!)
                }
                self.descLbl.text = "\(list.weather[0].description)"
                self.feelsLikeLbl.text = "Feels like \(list.main.temp)"
                self.HumidityLbl.text = "Humidity \(list.main.humidity)"
            }
        }
        
        
      /*  DispatchQueue.main.async {
            self.title = city
            self.temp.text = "Temp \(temp1.description)"
            self.Humidity.text = "Humidity \(humidity.description)"
        }*/
}
    

    override func viewWillAppear(_ animated: Bool) {
        WeatherManager.shared.delegate = self
        guard let city = country?.city else {
            return
        }
        WeatherManager.shared.fetchWeather(cityName: city)
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
