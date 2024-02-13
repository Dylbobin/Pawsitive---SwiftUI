//
//  registrationView.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/5/24.
//

import SwiftUI

struct registrationView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var action = "Sign User Up..."
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            // for out page view
            
            //image
            Image("PawIcon")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 140)
                .padding(.vertical, 40)
            
            //form fields
            VStack(spacing: 24) {
                inputView(text: $email, title: "Eamil Address", placeholder: "name@example.com")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                VStack(spacing: 24) {
                    inputView(text: $fullName, title: "Full Name", placeholder: "John Doe")
                }
                // Secure field obscures values
                inputView(text: $password, title: "Password", placeholder: "password", isSecureField: true)
                inputView(text: $confirmPassword, title: "Confirm Password", placeholder: "confirm password", isSecureField: true)
                
                // Sign Up
                signButton(action: $action, title: "Sign Up")
                
                Spacer()
                
                //Have an account, Sign in
                // Button in order to go back to login page using
                // environment dismiss
                Button {
                    dismiss()
                } label: {
                    // bring dont have a title together
                    HStack(spacing: 2) {
                        Text("Have an account?")
                        Text("Sign in")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(Color(.systemMint))
                    .font(.system(size: 14))
                }
            }
            .padding(.horizontal)
            
        }
    }
}


#Preview {
    registrationView()
}

