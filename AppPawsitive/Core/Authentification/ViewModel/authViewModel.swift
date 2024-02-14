//
//  authViewModel.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/12/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

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
        do {
            // completion handlers can be challenging
            // allows us to await the result from firebase
            // async code in a synchronus way
            
            //tries to create user
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            // if successful resule set user session
            self.userSession = result.user
            
            // create user with (id from firebase full name and user
            // Firebase user: generic firebase user object
                // all other infon we want will be stored in user model
            
            //our user object
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("ERROR: Fqailed to create user with error \(error.localizedDescription)")
        }
        
    }
    
    func signOut() {
        print("Sign Out user...")
    }
    
    func deleteAccount() {
        
    }
    
    func fetchUser() async {
        
    }
}

