//
//  AppPawsitiveApp.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/12/24.
//

import SwiftUI

@main
struct AppPawsitiveApp: App {
    // initialized here in order to work across all views
    @StateObject var viewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
