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
    @State private var signUpError = false
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    
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
                
                ZStack (alignment: .trailing){
                    inputView(text: $confirmPassword, title: "Confirm Password", placeholder: "confirm password", isSecureField: true)
                    if !password.isEmpty && !confirmPassword.isEmpty {
                        if password == confirmPassword {
                            Image(systemName: "checkmark.circle.fill")
                                .imageScale(.large)
                                .fontWeight(.bold)
                                .foregroundColor(Color(.systemGreen))
                                                 } else {
                                    Image(systemName: "xmark.circle.fill")
                                                         .imageScale(.large)
                                                         .fontWeight(.bold)
                                        .foregroundColor(Color(.systemRed))
                                }
                    }
                }
                
                // password checkmarks
                HStack(spacing: 10) {
                    
                    HStack(alignment: .firstTextBaseline){
                        if !yesUpper {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(.systemRed))
                                .imageScale(.small)
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(.systemGreen))
                                .imageScale(.small)
                        }
                        Text("Uppercase Letter")
                            .font(Font.system(size: 12))
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .foregroundColor(Color(.darkGray))
                    }
                    HStack(alignment: .firstTextBaseline) {
                        if !yesNumber {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(.systemRed))
                                .imageScale(.small)
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(.systemGreen))
                                .imageScale(.small)
                        }
                        Text("Number")
                            .font(Font.system(size: 12))
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .foregroundColor(Color(.darkGray))
                    }
                    HStack(alignment: .firstTextBaseline) {
                        if !yesLength {
                            Image(systemName: "xmark")
                                .foregroundColor(Color(.systemRed))
                                .imageScale(.small)
                        } else {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(.systemGreen))
                                .imageScale(.small)
                        }
                        Text("Length 8 Characters")
                            .font(Font.system(size: 12))
                            .fontWeight(.semibold)
                            .font(.subheadline)
                            .foregroundColor(Color(.darkGray))
                    }
                }
                
                // Sign Up
                Button {
                    Task {
                        signUpError = try await viewModel.createUser(withEmail: email, password: password, fullName: fullName)
                    }
                } label: {
                    HStack {
                        Text("Sign Up")
                            .fontWeight(.semibold)
                        Image(systemName: "arrow.right.circle")
                    }
                    .foregroundColor(.white)
                    // frame based on size of the screen
                    .frame(width: UIScreen.main.bounds.width - 132, height: 48)
                }
                .background(Color(.systemMint))
                // diable if credentials are not met
                .disabled(!validForm)
                .opacity(validForm ? 1.0 : 0.5)
                //half of height to make fully rounded
                .cornerRadius(24)
                .padding(.top, 24)
                
                if signUpError {
                    Text("User already exists")
                        .foregroundColor(Color(.systemRed))
                }
                
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

func containsSpace(_ str: String) -> Bool {
    for char in str {
        if char == (" ") {
            return true
        }
    }
    return false
}

extension registrationView : AuthentificationFormProtocol {
    var validForm: Bool {
        // can update credentials, ensures users sign in with correct formula
        return !email.isEmpty
        && email.contains("@")
        && email.contains(".")
        && !password.isEmpty
        && containsCapitalLetter(password)
        && containsNumber(password)
        && containsLength(password)
        && !fullName.isEmpty
        && containsSpace(fullName)
        && password == confirmPassword
    }
}

extension registrationView : AuthentificationPasswordProtocol {
    var yesUpper: Bool {
        containsCapitalLetter(password)
    }
    var yesNumber: Bool {
        containsNumber(password)
    }
    var yesLength: Bool {
        containsLength(password)
    }
}


#Preview {
    registrationView()
}

