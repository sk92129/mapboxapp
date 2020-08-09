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
    
    @State private var stopDetails = [StopDetail]() {
        didSet {
                // get called when the list is set
                DispatchQueue.main.async {
                    print("should look at results and load the map with meaningful data")
                    loadMap()
                }
            }
    }
    
            
    private func loadMap() -> Void {
        for item in stopDetails {
            myMapHolder.addStop(stop: item)
            break
        }
    }
    
    private func search (center : CLLocationCoordinate2D, radius: Double) -> Void {
        print("center")
        print (center)
        let mapService = MapService(lat: center.latitude, lon: center.longitude, radius: radius)
        mapService.getStops { (results) in
            self.stopDetails = results
        }

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
                    NavigationView {
                        List(stopDetails) { stopModel in
                            Text(stopModel.stop_name)
                        }
                        .navigationTitle(Text("Stops for Map"))
                    }
                    Spacer()
                }
                
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

