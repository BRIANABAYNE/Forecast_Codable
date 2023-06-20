//
//  NetworkController .swift
//  Forecast_Codable
//
//  Created by Briana Bayne on 6/20/23.
//

import Foundation
@available(iOS 16.0, *)

struct NetworkContoller {
    
    static func fetchDays(completion: (TopLevelDictonary?) -> Void) {
        
        guard let baseURL = URL(string: "https://api.weatherbit.io/v2.0") else {completion(nil);return }
        let urlComponents = baseURL.appending(path:"/forecast/daily"), resolvingAgainstBaseURL: true;)
        let urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let apiQuery = URLQueryItem(name: "key", value: "155585ef583b4c8ba5f6da56c96916ce")
        let cityQuery = URLQueryItem(name: "city", value: "Salt Lake City")
        let unitsQuery = URLQueryItem(name: "units", value:"I")
        urlComponents?.queryItems = [apiQuery,cityQuery,unitsQuery]
        guard let finalURL = urlComponents?.url else {completion(nil); return}
        
    }
    
    // data task
    URLSession.shared.dataTask(with: finalURL) { dayData, _, error in
        if let error {
            print("There was an error fetching the data. The url is\(finalURL)", error.localizedDescription)
            completion(nil); return
            
        } // decode the data
        guard let data = data else {completion(nil); return }
        
        do {
            let topLevelDictonary = try
            JSONDecoder().decode(topLevelDictonary.self,from: data)
        } catch {
            print("Error in Do/Try/Catch", error.localizedDescription)
            completion(nil); return
        }
        
        
        
        
    }.resume()
    
    
    
    
    
    
    
}







