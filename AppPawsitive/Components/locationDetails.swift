//
//  locationDetails.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 3/3/24.
//

import SwiftUI
import MapKit

struct locationDetails: View {
    
    @Binding var mapSelection : MKMapItem?
    @Binding var showDetails : Bool
    @State private var lookAround : MKLookAroundScene?
    
    var body: some View {
        Spacer()
        VStack {
            Spacer()
            HStack {
                VStack (alignment: .leading) {
                    // name of location
                    Text(mapSelection?.placemark.name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    // name of address
                    Text(mapSelection?.placemark.title ?? "")
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .lineLimit(2)
                        .padding(.trailing)
                        .clipped()
                }
                //Spacer()
                // dismiss sheet
                Button {
                    showDetails.toggle()
                    mapSelection = nil
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(.systemGray), Color(.systemGray5))
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
            
            if let scene = lookAround {
                LookAroundPreview(initialScene: scene)
                    .frame(height: 200)
                    .cornerRadius(12)
                    .padding()
            } else {
                ContentUnavailableView("No preview available", systemImage: "eye.slash")
            }
            HStack {
                // add label to open in maps natively
                Button{
                    if let mapSelection {
                        mapSelection.openInMaps()
                    }
                } label: {
                    // zStack to embed both text and image in rectange
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 190, height: 48)
                            .foregroundColor(.blue)
                        HStack {
                            Text("Open in Maps")
                                .font(.headline)
                                .foregroundColor(.white)
                            Image(systemName: "arrow.triangle.turn.up.right.circle")
                                .foregroundColor(.white)
                                .font(Font.system(size: 12))
                        }
                    }
                }
            }
                
        }
        .onAppear {
            // when details appear, fetch the preview
            fetchPreview()
        }
        .onChange(of: mapSelection) {
            // if map selection changes, fetch
            fetchPreview()
        }
        .padding()
    }
}

extension  locationDetails {
    func fetchPreview() {
        // if map selection is made by user
        if let mapSelection {
            // start the look around scene at nothinh
            lookAround = nil
            Task {
                // fetch the look around request
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAround = try? await request.scene
            }
        }
    }
}
#Preview {
    locationDetails(mapSelection: .constant(nil), showDetails: .constant(false))
}
