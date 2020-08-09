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
    init (lat: Double, lon: Double, radius: Double) {
        let resourceString = "http://192.168.0.144:3000/stopsbycircle?latitude=\(lat)&longitude=\(lon)&radius=\(radius)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        self.resourceURL = resourceURL
    }
    
    func getStops (completion: @escaping([StopDetail]) -> ()) {
        URLSession.shared.dataTask(with: resourceURL) {data, _, _ in

            let stopsResponse = try! JSONDecoder().decode(StopResponse.self, from: data!)
            let stopDetails = stopsResponse.response.stops
            DispatchQueue.main.async {
                completion(stopDetails)
            }
        }.resume()
    }
}
