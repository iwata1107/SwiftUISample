//
//  Sample2.swift
//  LocationSearch
//
//  Created by 岩田照太 on 2022/08/14.
//

import SwiftUI
import MapKit

struct IdentifiablePlace: Identifiable {
    let id: UUID
    let location: CLLocationCoordinate2D
    init(id: UUID = UUID(), lat: Double, long: Double) {
        self.id = id
        self.location = CLLocationCoordinate2D(
            latitude: lat,
            longitude: long)
    }
}

struct Sample2: View {
    //@State var place:IdentifiablePlace = IdentifiablePlace(lat: 37.334_900, long: -122.009_020)
    @State private var places: [IdentifiablePlace] = [
           // Steve Jobs Theater
           IdentifiablePlace(lat: 33.59121091171399,  long: 130.40402964108628),
           // Apple Park Tantau Reception
           IdentifiablePlace(lat: 37.332_44,  long: -122.006_14)
       ]
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 33.59121091171399, longitude: 130.40402964108628),
        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems:places,
            annotationContent: { place in
            MapPin(coordinate: place.location, tint: Color.red)})
    }
}

struct Sample2_Previews: PreviewProvider {
    static var previews: some View {
        Sample2()
    }
}
