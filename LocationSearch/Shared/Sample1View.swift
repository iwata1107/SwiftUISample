//
//  Sample1View.swift
//  LocationSearch
//
//  Created by 岩田照太 on 2022/08/13.
//

import SwiftUI
import CoreLocationUI
import CoreLocation

struct Sample1View: View {
    @StateObject var locationClient = LocationClient()
    
    var body: some View {
        VStack {
            VStack {
                Text("[位置情報]")
                if let location = locationClient.location {
                    Text("緯度：\(location.latitude)")
                    Text("経度：\(location.longitude)")
                } else {
                    Text("緯度：----")
                    Text("経度：----")
                }
            }
            LocationButton(.currentLocation) {
                locationClient.requestLocation()
            }
            .foregroundColor(.white)
            .cornerRadius(30)
            if (locationClient.requesting) {
                ProgressView()
            }
        }
    }
}

struct Sample1View_Previews: PreviewProvider {
    static var previews: some View {
        Sample1View()
    }
}



class LocationClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var requesting: Bool = false
    
    override init() {
        super.init()
        locationManager.delegate = self;
    }
    
    func requestLocation() {
        request()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        request()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        requesting = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        requesting = false
    }
    
    private func request() {
        if (locationManager.authorizationStatus == .authorizedWhenInUse) {
            requesting = true
            locationManager.requestLocation()
        }
    }
}

