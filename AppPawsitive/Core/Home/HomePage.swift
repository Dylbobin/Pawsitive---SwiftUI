//
//  HomePage.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/19/24.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @Binding var selection : Int
    
    var body: some View {
        //if let user = viewModel.currentUser {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Home")
                        .padding(.top, 40)
                        .padding(.bottom, 0.45)
                        .padding(.trailing, UIScreen.main.bounds.width - 130)
                        .foregroundColor(.white)
                    ZStack {
                        HStack {
                            VStack() {
                                Text("Hi name,")
                                //Text("Hello \(user.fullName")
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.bottom, 10)
                                    .font(Font.system(size: 40))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Image("stock-dog-image")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.trailing, 30)
                        }
                    }
                    petSelector()
                        .padding(.bottom, 10)
                    HStack(spacing: 20) {
                        navigationButton(imageName: "cross.case.fill", title: "Hospital", imageLead: 90, textTrail: 20, selection: $selection)
                        navigationButton(imageName: "dog.fill", title: "Dog Park", imageLead: 90, textTrail: 20,  selection: $selection)
                    }
                    /*
                    HStack(spacing: 20) {
                        navigationButton(imageName: "cross.case.fill", title: "Activities", imageLead: 90, textTrail: 20)
                        navigationButton(imageName: "cross.case.fill", title: "Supplies", imageLead: 90, textTrail: 20)
                    }
                     */
                    HStack(spacing: 20) {
                        navigationButton(imageName: "storefront.fill", title: "Store", imageLead: 90, textTrail: 20,  selection: $selection)
                        navigationButton(imageName: "timelapse", title: "All", imageLead: 90, textTrail: 20,  selection: $selection)
                    }
                    Spacer()
                }
            }
        //}
    }
}
/*
#Preview {
    //HomePage().environmentObject(AuthViewModel())
    HomePage(selection: selection)
}
*/
