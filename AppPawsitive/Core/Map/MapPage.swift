//
//  MapPage.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/19/24.
//

import SwiftUI
import MapKit

struct MapPage: View {
    // custom zoom on user region
    @State private var cameraPosition : MapCameraPosition = .region(.userRegion)
    @State private var searchText : String = ""
    @State private var results = [MKMapItem]()
    @State private var itemSelectionMap : MKMapItem?
    @State private var showDetails : Bool = false
    
    var body : some View {
        // can make custom views with annotation
        // allow items to display selected itemon map with seletion
        Map(position: $cameraPosition, selection: $itemSelectionMap) {
            Marker("My location", systemImage: "person.circle", coordinate: .userLocation)
                .tint(.blue)
            
            // loop through the results array
            ForEach(results, id: \.self) { item in
                // for each item
                // let location mark be the item placemark
                let locationMark = item.placemark
                // set marker of the name and coordinat
                Marker(locationMark.name ?? "", coordinate: locationMark.coordinate)
                
            }
        }
        .overlay(alignment: .top) {
            // add a search bar
            GeometryReader { geometry in
                TextField("Search for location...", text: $searchText)
                    .font(.subheadline)
                    .padding(12)
                //.tint(Color.gray)
                    .foregroundStyle(.gray,(Color(.black)))
                    .background(.white)
                    .opacity(0.85)
                    .padding()
                    .shadow(radius: 10)
                    .frame(width: geometry.size.width - 50)
            }
            
        }
        .onSubmit(of: /*@START_MENU_TOKEN@*/.text/*@END_MENU_TOKEN@*/) {
            // when code is submitted
            Task { await searchLocation() }
        }
        // adds a look around functionality
        .onChange(of: itemSelectionMap, { oldValue, newValue in
            // show details if newValue is not equal to nil
            // onlyn show details if selecting an actual annotation
            showDetails = newValue != nil
        })
        .sheet(isPresented: $showDetails, content: {
            // call show details view
            locationDetails(mapSelection: $itemSelectionMap, showDetails: $showDetails)
            // allow interacting with map view up to the height of the details
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled(upThrough: .height(340)))
                .presentationCornerRadius(12)
            // show page navigation buttons??

        })
        .mapControls() {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        
    }
}

// sets user location to miami
extension CLLocationCoordinate2D {
    static var userLocation : CLLocationCoordinate2D {
        return .init(latitude: 25.7602, longitude: -80.1959)
    }
}

//sets the user range for a zoom
extension MKCoordinateRegion {
    static var userRegion : MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}

extension MapPage {
    func searchLocation() async {
        let searchLocation = MKLocalSearch.Request()
        searchLocation.naturalLanguageQuery = searchText
        // set region for requests
        searchLocation.region = .userRegion
        
        
        // store results in an array
        let results = try? await MKLocalSearch(request: searchLocation).start()
        self.results = results?.mapItems ?? [ ]
        
    }
}

#Preview {
    MapPage()
}
