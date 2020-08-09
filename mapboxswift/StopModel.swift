//
//  StopModel.swift
//  mapboxswift
//
//  Created by Sean Kang on 8/8/20.
//

import SwiftUI


struct StopModel : Identifiable {
    var id = UUID()
    
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



#if DEBUG
let testData = [
    StopModel( stop_id: "55", stop_code: "33", stop_name: "8th Street",stop_desc: "111", stop_lat: 34.22222, stop_lon: -73.848484, zone_id: "", stop_url: "", location_type: 0, parent_station: "", agency_key: ""),
    StopModel( stop_id: "55", stop_code: "33", stop_name: "NYU Station", stop_desc: "111", stop_lat: 34.22222, stop_lon: -73.848484, zone_id: "", stop_url: "", location_type: 0, parent_station: "", agency_key: ""),
   
]
#endif
