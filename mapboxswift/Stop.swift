//
//  Stop.swift
//  mapboxswift
//
//  Created by Sean Kang on 8/7/20.
//

import Foundation

struct StopResponse:Decodable {
    var response:  Stops
}

struct Stops:Decodable {
    var stops: [StopDetail]
}

struct StopDetail : Decodable {
    var stop_id: String
    var stop_code: String
    var stop_name: String
    var stop_desc: String
    var stop_lat: Double
    var stop_lon: Double
    var zone_id: String
    var stop_url: String
    var location_type: Int
    var parent_station: String
    var agency_key: String
}
