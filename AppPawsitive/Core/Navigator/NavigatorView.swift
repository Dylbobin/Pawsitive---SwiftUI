//
//  NavigatorView.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/19/24.
//

import SwiftUI

struct NavigatorView: View {
    @State var selection = 0
    @State var searchItem = ""
    
    var body: some View {
        TabView(selection: $selection) {
            
            // what page looks liike
            // added another view to work on this HomePage screen
            // shows the home page screen, cleans up code
            HomePage(selection: $selection, searchItem: $searchItem)
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
            MapPage(searchItem: $searchItem)
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "map.circle.fill")
                        Text("Map")
                    }
                }
                .tag(1)
        }
        .border(Color.clear, width: 0)
    }
}
/*
#Preview {
    let searchItem = Binding.constant("")
    NavigatorView(searchItem: searchItem)
}
*/

