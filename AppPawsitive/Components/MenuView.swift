//
//  MenuView.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 3/21/24.
//

import SwiftUI

// style the sliding menu
struct MenuView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var showingDeleteAlert : Bool = false
    @Binding var showingProfile : Bool
    @Binding var showingPet : Bool
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Button {
                    showingProfile = true
                } label: {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 100)
            HStack{
                Button {
                    showingPet = true
                } label: {
                    Image(systemName: "pawprint")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Pets")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
            }
            .padding(.top, 30)
            Spacer()
            HStack{
                Button {
                    viewModel.signOut()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(Color(.red))
                    Text("Sign Out")
                        .foregroundColor(.red)
                        .font(.headline)
                }
            }
            Spacer()
        }
        .padding(.top, 100)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .opacity(0.90)
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    MenuView(showingProfile: .constant(false), showingPet: .constant(false)).environmentObject(AuthViewModel())
}
