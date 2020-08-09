//
//  StopModelDetail.swift
//  mapboxswift
//
//  Created by Sean Kang on 8/8/20.
//

import Foundation


import SwiftUI

struct StopModelDetail : View {
    var name: String
    var desc: String
    
    var body: some View {
        VStack {
            Image(name)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.orange, lineWidth: 4)
                )
                .shadow(radius: 10)
            Text(name)
                .font(.title)
            Text(desc)
                .font(.subheadline)

            }.padding().navigationBarTitle(Text(name), displayMode: .inline)
    }
}

#if DEBUG
struct StopModelDetail_Previews : PreviewProvider {
    static var previews: some View {
        StopModelDetail(name: "8th Street", desc: "8th Street Station")
    }
}
#endif
