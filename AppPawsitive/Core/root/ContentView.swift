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
            if viewModel.userSession == nil {
                LoginPage()
            } else {
                profileView()
            }
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel())
}
