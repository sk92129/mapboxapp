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
           MGLPointAnnotation(title: "Mapbox", coordinate: .init(latitude: 37.791434, longitude: -122.396267))
       ]
    
    @State private var name: String = ""
    private var canRegister: Bool {
        name.count >= 3 && name.count <= 16
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .center) {
                    
                    VStack {
                        TextField("Enter your name...", text: self.$name.animation())
                        Color.primary.frame(height: 1.0)
                    }
                    .padding()
                    MapboxMap(annotations: $annotations).centerCoordinate(.init(latitude: 37.791293, longitude: -122.396324)).zoomLevel(16)
                    .padding()
                    List() {
                        Text("result 1")
                            
                        Text("result 2")
                        Text("result 3")
                    }

                    .opacity(self.canRegister ? 1.0 : 0.5)
                    .disabled(!self.canRegister)

                    Spacer()
                }
                
            }
        }
    }
}
