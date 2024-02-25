//
//  profileView.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/5/24.
//

import SwiftUI

struct profileView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var imageTitle = ""
    @State private var joinDate = "05-22-2002"
    @State private var showingDeleteAlert : Bool = false
    
    var body: some View {
        /* Want to include an image at the top
         Image("PawIcon")
         .resizable()
         .scaledToFill()
         .frame(width: 60, height: 70)
         // fix centering
         .padding(.vertical, 40)
         */
        if let user = viewModel.currentUser {
            List() {
                Section("Profile") {
                    HStack {
                        /*
                         if imageTitle.isEmpty(false) {
                         Image(imageTitle)
                         } else {
                         Text(initials)
                         .font(.title)
                         .fontWeight(.semibold)
                         .foregroundStyle(.white)
                         .frame(width: 72, height: 72)
                         .background(Color(.systemGray3))
                         .clipShape(Circle())
                         */
                        Text(user.initials)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(width: 72, height: 72)
                            .background(Color(.systemGray3))
                            .clipShape(Circle())
                        VStack(alignment: .leading, spacing: 4){
                            Text(user.fullName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            Text(user.email)
                                .font(.footnote)
                            //.accentColor(.gray) - redated due to pulling from external User.MOCK_USER.
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                }
                // abput section for join date
                // Could add possible pet count
                Section("About") {
                    HStack {
                        settingsRowView(imageName: "calendar", title: "Join Date", tintColor: Color(.systemGray))
                        
                        Spacer()
                        
                        Text(joinDate)
                            .font(.subheadline)
                            .foregroundColor(Color(.systemGray))
                    }
                }
                Section("Account") {
                    Button{
                        viewModel.signOut()
                    } label : {
                        settingsRowView(imageName: "arrow.backward.circle", title: "Sign Out", tintColor: Color(.red))
                            .foregroundColor(Color(.systemGray))
                    }
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
            }
        }
    }
}
#Preview {
    profileView()
        .environmentObject(AuthViewModel())
}



