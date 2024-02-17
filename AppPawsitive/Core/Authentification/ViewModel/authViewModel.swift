//
//  authViewModel.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/12/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

// protocol to have auth conform to protocol
protocol AuthentificationFormProtocol {
    var validForm : Bool { get }
}

protocol AuthentificationPasswordProtocol {
    var yesUpper : Bool { get }
    var yesNumber : Bool { get }
    var yesLength : Bool { get }
}

// responsible for
    // functionality to auth user
    // update UI when needed
    //form validation
    // networking

    //error message

// publish UI changes on the Main thread
@MainActor
class AuthViewModel : ObservableObject {

    // user logged in or not, where to route (firebase)
    @Published var userSession : FirebaseAuth.User?
    // our current user
    @Published var currentUser : User?
    
    init() {
        // when auth view initializes, it checks if there is a current user logged in on local device
        // if it has a value, will show us the profile view
        self.userSession = Auth.auth().currentUser
        
        // when do we want to fetch user
        Task {
            await fetchUser()
        }
        
    }
    
    // async/await fucntionality
    // network better using this
    func signIn(withEmail email : String, password : String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            // if sign in happens, we must fetch user from firebase to populate
            // await must wait in order to fetch the user
            await fetchUser()
        } catch {
            print("ERROR: failed to login with error \(error.localizedDescription)")
        }
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
            
            //our user object - encoded in JSON for firebase
            let user = User(id: result.user.uid, fullName: fullName, email: email)
            
            let encodedUser = try Firestore.Encoder().encode(user)
            
            // this should make a collection for the users in firestore database
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            // we need to fetch data uploaded to firebase to have the data uploaded onto screen
            await fetchUser()
        } catch {
            print("ERROR: Failed to create user with error \(error.localizedDescription)")
        }
        
    }
    
    func signOut() {
        do {
            // sign out user on backend
            try Auth.auth().signOut()
            // wipe current user and session to show login view
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print("ERROR: Failed to sign user out \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
        
        // Get the current user
        if let user = Auth.auth().currentUser {
            
            // Delete the user from Firebase Authentication
            user.delete { error in
                if let error = error {
                    print("Error deleting account from Authentication: \(error.localizedDescription)")
                    return
                }
                
                // Sign out the user
                do {
                    try Auth.auth().signOut()
                    DispatchQueue.main.async {
                        self.userSession = nil
                        self.currentUser = nil
                        print("User signed out successfully after account deletion.")
                    }
                } catch {
                    print("Error signing out user: \(error.localizedDescription)")
                }
            }
            // Delete the user's data from Firestore
            Firestore.firestore().collection("users").document(user.uid).delete { error in
                if let error = error {
                    print("Error deleting account data from Firestore: \(error.localizedDescription)")
                    return
                }
            }
        }
    }


    
    func fetchUser() async {
        // fetch from firebase firestore
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        // setting currentUser property with the snapshot
        self.currentUser = try? snapshot.data(as: User.self)
        // check if it is successfullly fetching
        // comes back from firebase into user model
            // conforms to the codable protocol - JSON mapped to data object
        //print("Current: current user is \(self.currentUser)")
    }
}

