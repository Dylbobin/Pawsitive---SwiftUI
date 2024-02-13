//
//  LoginPage.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/5/24.
//

import SwiftUI

struct LoginPage: View {
    @State private var email = ""
    @State private var password = ""
    @State private var action = "Log User In..."
    @EnvironmentObject var viewModel : AuthViewModel    
    var body: some View {
        NavigationStack {
            VStack {
                // for out page view
                
                //image
                Image("PawIcon")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 140)
                // fix centering
                    .padding(.vertical, 40)
                
                //form fields
                VStack(spacing: 24) {
                    inputView(text: $email, title: "Eamil Address", placeholder: "name@example.com")
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    // Secure field obscures values
                    inputView(text: $password, title: "Password", placeholder: "password", isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                //sign in button: Created in components
                Button {
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("Sign In")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right.circle")
                    }
                    .foregroundColor(.white)
                    // frame based on size of the screen
                    .frame(width: UIScreen.main.bounds.width - 132, height: 48)
                }
                .background(Color(.systemMint))
                //half of height to make fully rounded
                .cornerRadius(24)
                .padding(.top, 24)
                
                Spacer()
                //sign up button
                //Nav Link to open up a new page: Registration
                NavigationLink {
                    registrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    // bring dont have a title together
                    HStack(spacing: 2) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(Color(.systemMint))
                    .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    LoginPage()
}

