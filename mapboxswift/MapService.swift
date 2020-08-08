//
//  MapService.swift
//  mapboxswift
//
//  Created by Sean Kang on 8/7/20.
//

import Foundation


enum StopError:Error {
    case noDataAvailable
    case canNotProcessData
}

struct MapService {
    
    let resourceURL: URL
    let API_KEY = ""
    init (lat: Double, lon: Double, radius: Double) {
        let resourceString = "http://192.168.0.144:3000/stopsbycircle?latitude=\(lat)&longitude=\(lon)&radius=\(radius)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
        
    }
    
    func getStops (completion: @escaping(Result<[StopDetail], StopError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                print(jsonData)
                let stopsResponse = try decoder.decode(StopResponse.self, from: jsonData)
                let stopDetails = stopsResponse.response.stops
                completion(.success(stopDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}
