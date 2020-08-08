//
//  MapboxMap.swift
//  mapboxswift
//
//  Created by Sean Kang on 8/6/20.
//

import Foundation
import SwiftUI
import Mapbox




struct MapboxMap: UIViewRepresentable {
    //@Binding var annotations: [MGLPointAnnotation]
    
    
    private let mapView: MGLMapView = MGLMapView(frame: .zero, styleURL: MGLStyle.streetsStyleURL)
    
    func makeUIView(context: UIViewRepresentableContext<MapboxMap>) -> MGLMapView {
       
        return mapView
    }
    
    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<MapboxMap>) {
        updateAnnotations()
    }
    

    
    func makeCoordinator() -> MapboxMap.Coordinator {
           Coordinator(self)
       }
    
    
    func styleURL(_ styleURL: URL) -> MapboxMap {
        mapView.styleURL = styleURL
        return self
    }

    func centerCoordinate(_ centerCoordinate: CLLocationCoordinate2D) -> MapboxMap {
        mapView.centerCoordinate = centerCoordinate
        return self
    }

    func zoomLevel(_ zoomLevel: Double) -> MapboxMap {
        mapView.zoomLevel = zoomLevel
        return self
    }
    
    private func updateAnnotations() {
        let annotations: [MGLPointAnnotation] = [
               MGLPointAnnotation()
           ]
        if let currentAnnotations = mapView.annotations {
            mapView.removeAnnotations(currentAnnotations)
        }
        mapView.addAnnotations(annotations)
    }
    
    public func getNE() -> CLLocationCoordinate2D  {
        let visibleCoordinates = mapView.visibleCoordinateBounds
        return visibleCoordinates.ne
    }
    
    public func getSW() -> CLLocationCoordinate2D  {
        let visibleCoordinates = mapView.visibleCoordinateBounds
        return visibleCoordinates.sw
    }
    
    public func getCenter() -> CLLocationCoordinate2D  {
        return mapView.centerCoordinate
    }
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: MapboxMap
        
        init(_ control: MapboxMap) {
            self.control = control
        }
        
        func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
            
            let coordinates = [
                CLLocationCoordinate2D(latitude: 40.731457, longitude: -73.994279),
                CLLocationCoordinate2D(latitude: 40.731511, longitude: -73.988598),
                CLLocationCoordinate2D(latitude: 40.728938, longitude: -73.988693),
                CLLocationCoordinate2D(latitude: 40.729151, longitude: -73.994284),
                CLLocationCoordinate2D(latitude: 40.731457, longitude:  -73.994279),
            ]
            
            let buildingFeature = MGLPolygonFeature(coordinates: coordinates, count: 5)
            let shapeSource = MGLShapeSource(identifier: "buildingSource", features: [buildingFeature], options: nil)
            mapView.style?.addSource(shapeSource)
            
            let fillLayer = MGLFillStyleLayer(identifier: "buildingFillLayer", source: shapeSource)
            fillLayer.fillColor = NSExpression(forConstantValue: UIColor.blue)
            fillLayer.fillOpacity = NSExpression(forConstantValue: 0.5)
            
            mapView.style?.addLayer(fillLayer)

        }
        
        func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            return nil
        }
         
        func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
            return true
        }
        
    }
    
}

