//
//  MainView.swift
//  mapboxswift
//
//  Created by Sean Kang on 8/6/20.
//


import SwiftUI
import Mapbox

struct MainView: View {
    @State var annotations: [MGLPointAnnotation] = [
           MGLPointAnnotation()
       ]
    
    @State private var name: String = ""
    
    @State private var listOfStops = [StopDetail]() {
        didSet {
            // get called when the list is set
            DispatchQueue.main.async {
                print("should reload the list/table UI")
            }
        }
    }
    
    
    private func search (center : CLLocationCoordinate2D, radius: Double) -> Bool {
        print("center")
        print (center)
        let mapService = MapService(lat: center.latitude, lon: center.longitude, radius: radius)
        mapService.getStops { result in
            switch result {
            case .failure (let error):
                print(error)
            case .success(let stops):
                self.listOfStops = stops
            }
            
        }
        return false
    }
    

    
    let myMapHolder = MapboxMap().centerCoordinate(.init(latitude: 40.730340, longitude: -73.991712)).zoomLevel(16)

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .center) {
                    
                    VStack {
                        TextField("Enter your name...", text: self.$name.animation(),
                                  onEditingChanged: { edit in
                                              print("edit = \(edit)")
                                            },
                                            onCommit: {
                                                
                                                print(myMapHolder.getCenter())
                                                // 1.0 mile for now.
                                                self.search(center: myMapHolder.getCenter(), radius: 1.0)
                                              print("COMITTED!")
                                                
                                            })
                        Color.primary.frame(height: 1.0)
                    }
                    .padding()
                    myMapHolder
                    .padding()
                    List() {
                        Text("result 1")
                            
                        Text("result 2")
                        Text("result 3")
                    }

                    
                    

                    Spacer()
                }
                
            }
        }
    }
}
