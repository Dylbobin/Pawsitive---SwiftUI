//
//  authViewModel.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/12/24.
//

import Foundation
import Firebase

// responsible for
    // functionality to auth user
    // update UI when needed
    //form validation
    // networking

    //error message

class AuthViewModel : ObservableObject {

    // user logged in or not, where to route (firebase)
    @Published var userSession : FirebaseAuth.User?
    // our current user
    @Published var currentUser : User?
    
    init() {
        
    }
    
    // async/await fucntionality
    // network better using this
    func signIn(withEmail email : String, password : String) async throws {
        print("Sign In user...")
    }
    
    func createUser(withEmail email : String, password : String, fullName : String) async throws {
        print("Creating User...")
    }
    
    func signOut() {
        print("Sign Out user...")
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}

