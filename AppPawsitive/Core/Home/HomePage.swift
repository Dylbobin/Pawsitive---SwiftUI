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
    @Binding var searchItem : String
    @State var showMenu = false
    @State var showingProfile = false
    @State var showingPet = false
    
    var body: some View {
        //if let user = viewModel.currentUser {
        let dragGesture = DragGesture()
            .onEnded {
                if $0.translation.width > 100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
            if showingProfile == true {
                mainProfileView(showProfile: $showingProfile)
            } else if showingPet == true {
                petView(showingPet: $showingPet)
            } else {
            ZStack {
                VStack {
                        Text("Home")
                            .padding(.top, 40)
                            .padding(.bottom, 0.45)
                            .padding(.trailing, UIScreen.main.bounds.width - 130)
                            .foregroundColor(.black)
                        HStack {
                            VStack() {
                                //Text("Hi \(user.firstName),")
                                Text("Hi Name,")
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                    .padding(.bottom, 10)
                                    .font(.custom("comic Sans MS", size: 40))
                                    .bold()
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            Image("stock-dog-image")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(Circle())
                                .padding(.trailing, 30)
                        }
                    petSelector()
                        .padding(.bottom, 10)
                    HStack(spacing: 20) {
                        navigationButton(imageName: "cross.case.fill", title: "Hospital", imageLead: 90, textTrail: 20, selection: $selection, searchItem: $searchItem)
                        navigationButton(imageName: "dog.fill", title: "Dog Park", imageLead: 90, textTrail: 20,  selection: $selection, searchItem: $searchItem)
                    }
                    HStack(spacing: 20) {
                        navigationButton(imageName: "storefront.fill", title: "Store", imageLead: 90, textTrail: 20,  selection: $selection, searchItem: $searchItem)
                        navigationButton(imageName: "timelapse", title: "All", imageLead: 90, textTrail: 20,  selection: $selection, searchItem: $searchItem)
                    }
                    Spacer()
                }
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        if self.showMenu {
                            MenuView(showingProfile: $showingProfile, showingPet: $showingPet)
                                .frame(width: geometry.size.width/2)
                                .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                            // animation
                                .transition(.move(edge: .trailing))
                        }
                    }
                    Button {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    } label: {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                            .foregroundColor(showMenu ? .gray : .black)
                    }
                    .padding()
                    .padding(.leading, geometry.size.width - 70)
                }
                
            }
            .gesture(dragGesture)
            .background(
                GeometryReader { geometry in
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(red: 75/255.0, green: 200/255.0, blue: 135/255.0), Color(.systemGray3), .white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .edgesIgnoringSafeArea(.all)
                        Image("PawIcon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width - 300, height: geometry.size.height - 580)
                            .padding(.top, geometry.size.height - 150)
                            .opacity(0.35)
                    }
                }
            )
        }
    }
}

#Preview {
    
    //HomePage().environmentObject(AuthViewModel())
    HomePage(selection: Binding.constant(0), searchItem: Binding.constant(""))
}

