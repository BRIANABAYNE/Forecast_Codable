//
//  NetworkController .swift
//  Forecast_Codable
//
//  Created by Briana Bayne on 6/20/23.
//

import Foundation
@available(iOS 16.0, *)

struct NetworkContoller {
    
    static func fetchDays(completion: @escaping (TopLevelDictonary?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.weatherbit.io/v2.0") else {return }
        let dailyURL = baseURL.appending(path:"/forecast/daily")
        var urlComponents = URLComponents(url: dailyURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: "key", value: "155585ef583b4c8ba5f6da56c96916ce")
        let cityQuery = URLQueryItem(name: "city", value: "Salt Lake City")
        let unitsQuery = URLQueryItem(name: "units", value:"I")
        urlComponents?.queryItems = [apiQuery,cityQuery,unitsQuery]
        guard let finalURL = urlComponents?.url else {completion(nil); return}
        
        URLSession.shared.dataTask(with: finalURL) { dayData, _, error in
            if let error  = error {
                print("There was an error fetching the data. The url is\(finalURL)", error.localizedDescription)
                completion(nil)
            }
            guard let dataData = dayData else {
                print("There was an error checking for Data.")
                completion(nil)
                return }
            do {
                let topLevelDictonary = try
                        JSONDecoder().decode(TopLevelDictonary.self, from: dataData)
                completion(topLevelDictonary)
    
            } catch {
                print("Error in Do/Try/Catch", error.localizedDescription)
                completion(nil); return
            }
            
        }.resume()
    }
}
