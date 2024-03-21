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
    @State private var cameraPosition : MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var searchText : String = ""
    @State private var results = [MKMapItem]()
    @State private var itemSelectionMap : MKMapItem?
    @State private var showDetails : Bool = false
    @State private var tintColor : Color = Color.red
    @Binding var searchItem : String
    
    var body : some View {
        // can make custom views with annotation
        // allow items to display selected itemon map with seletion
        Map(position: $cameraPosition, selection: $itemSelectionMap) {
/*
            Marker("My location", systemImage: "person.circle", coordinate: .userLocation.)
                .tint(.blue)

*/
            // loop through the results array
            ForEach(results, id: \.self) { item in
                // for each item
                // let location mark be the item placemark
                let locationMark = item.placemark
                // set marker of the name and coordinat
                let imageTitle = setMarker()
                Marker(locationMark.name ?? "", systemImage: imageTitle, coordinate: locationMark.coordinate)
                    .tint(tintColor)
                
            }
        }
        .overlay(alignment: .top) {
            // add a search bar
            GeometryReader { geometry in
                // if searchItem is not empty, search for search item, if not, use search text
                    TextField("Search for location...", text: searchItem != "" ? $searchItem : $searchText)
                        .font(.subheadline)
                        .padding(12)
                        .foregroundStyle(.gray, Color.black)
                        .background(Color.white)
                        .opacity(0.85)
                        .padding()
                        .shadow(radius: 10)
                        .frame(width: geometry.size.width - 50)
                        .onAppear() {
                            Task() { await searchLocation()}
                        }
                        .onChange(of: searchText) {
                            // reset after search
                            searchItem = ""
                        }
                }
        }
        .onAppear {
            // prompt user to accept location
            CLLocationManager().requestWhenInUseAuthorization()
        }
        .onSubmit(of: /*@START_MENU_TOKEN@*/.text/*@END_MENU_TOKEN@*/) {
            // when location is submitted
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
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .gray, .white]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}


// sets user location to user Loaction
 extension CLLocationManager {
     static var userLocation: CLLocationManager {
         let manager = CLLocationManager()
         manager.requestWhenInUseAuthorization()
         return manager
     }
 }

//sets the user range for a zoom
extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        guard let userLocation = CLLocationManager().location else {
            // Default region if user location is not available
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), latitudinalMeters: 10000, longitudinalMeters: 10000)
        }

        return MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
    }
}

extension MapPage {
    func searchLocation() async {
        let searchLocation = MKLocalSearch.Request()
        // added for when user clicks a button
        // checks which to run
        if searchItem != ""{
            searchLocation.naturalLanguageQuery = searchItem
        } else {
            searchLocation.naturalLanguageQuery = searchText
        }
        
        // set the region for the search request
        searchLocation.region = MKCoordinateRegion.userRegion
        
        // Perform the search request
        // store results in an array
        let results = try? await MKLocalSearch(request: searchLocation).start()
        self.results = results?.mapItems ?? [ ]
        
        //return results
    }
}

extension MapPage {
    func setMarker() -> String{
        let currentSearch = searchItem != "" ? searchItem : searchText
        
        var imageTitle = ""
        
        switch String(currentSearch) {
        case "Pet Hospitals":
            imageTitle = "cross.case.circle"
            tintColor = Color.red
        case "Dog Parks":
            imageTitle = "tree.circle"
            tintColor = Color.green
        case "Pet Stores":
            imageTitle = "Pet Stores"
            tintColor = Color.white
        case "All":
            imageTitle = "ALL"
            tintColor = Color.yellow
        default:
            imageTitle = ""
            tintColor = Color.red
        }
        return imageTitle
    }
}

#Preview {
    MapPage(searchItem: Binding.constant(""))
}




