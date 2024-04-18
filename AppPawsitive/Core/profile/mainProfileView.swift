//
//  mainProfileView.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 4/17/24.
//

import SwiftUI

struct mainProfileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var imageTitle = ""
    @State private var joinDate = "05-22-2002"
    @State private var showingDeleteAlert : Bool = false
    @Binding var showProfile : Bool
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Button {
                    showProfile = false
                } label: {
                    Text("Back")
                        .font(.system(size: 16))
                }
                .foregroundColor(.red)
                .padding(.trailing, 15)
            }
            HStack() {
                Text("Profile")
                    .font(.system(size: 30))
                    .font(.headline)
                    .padding(.leading, 10)
                Spacer()
            }
            VStack() {
                Text("TE")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 72, height: 72)
                    .background(Color(.systemGray3))
                    .clipShape(Circle())
                VStack(){
                    Text("Test Example")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .padding(.top, 4)
                    Text("Test@Example.com")
                        .font(.footnote)
                    //.accentColor(.gray) - redated due to pulling from external User.MOCK_USER.
                        .foregroundColor(Color(.systemGray))
                }
                
            }
            .padding(10)
            HStack() {
                Text("About")
                    .font(.system(size: 24))
                    .font(.subheadline)
                    .padding(.leading, 10)
                Spacer()
            }
            VStack(alignment: .leading){
                HStack {
                    settingsRowView(imageName: "person.crop.circle", title: "Full Name", tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("joinDate")
                        .font(.subheadline)
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                HStack {
                    settingsRowView(imageName: "calendar", title: "Join Date", tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("joinDate")
                        .font(.subheadline)
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                HStack {
                    settingsRowView(imageName: "mail", title: "Email", tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("Test@example.com")
                        .font(.subheadline)
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                HStack {
                    settingsRowView(imageName: "pawprint.circle", title: "Pets", tintColor: Color(.systemGray))
                    
                    Spacer()
                    
                    Text("0")
                        .font(.subheadline)
                        .foregroundColor(Color(.systemGray))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
            }
            VStack {
                /*
                Button{
                    
                } label : {
                    settingsRowView(imageName: "arrow.backward.circle", title: "Sign Out", tintColor: Color(.red))
                        .foregroundColor(Color(.systemGray))
                }
                 */
                Button{
                    // account deletion alert
                    showingDeleteAlert = true
                } label : {
                    settingsRowView(imageName: "x.circle", title: "Delete Account", tintColor: Color(.red))
                        .foregroundColor(Color(.systemGray))
                }
                .alert("Are you certain you wish to delete your account? This action is irreversible.", isPresented: $showingDeleteAlert) {
                    Button("Delete", role: .destructive) {
                        viewModel.deleteAccount()
                    }
                    Button("Cancel", role: .cancel) { }
                }
            }
            .padding(.vertical, 20)
            Spacer()
            Spacer()
            
        }
    }
}

#Preview {
    mainProfileView(showProfile: .constant(false)).environmentObject(AuthViewModel())
}
