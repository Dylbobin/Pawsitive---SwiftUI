//
//  NavigatorView.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/19/24.
//

import SwiftUI

struct NavigatorView: View {
    @State private var selection = 0
    var body: some View {
        TabView(selection: $selection) {
            // what page looks liike
            // added another view to work on this HomePage screen
            // shows the home page screen, cleans up code
            HomePage()
                .font(.title)
            // what icon on bottom looks like
                .tabItem {
                    VStack {
                        Image(systemName: "house.circle.fill")
                        Text("Home")
                    }
                }
                .tag(0)
            //This will follow suit of the first page, more specific comments can and will be added if need
            MapPage()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "map.circle.fill")
                        Text("Map")
                    }
                }
                .tag(1)
            profileView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "person.crop.circle.fill")
                        Text("Profile")
                    }
                }
                .tag(2)
        }
    }
}

/*
#Preview {
    NavigatorView()
}
*/
