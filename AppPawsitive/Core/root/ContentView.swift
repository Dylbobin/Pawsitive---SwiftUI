//
//  ContentView.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/12/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        Group {
            // listen for cnanges form authViewModel
            if viewModel.userSession == nil {
                LoginPage()
            } else {
                NavigatorView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}
