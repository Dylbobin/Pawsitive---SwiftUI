//
//  authViewModel.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/12/24.
//

import SwiftUI
import Foundation
import Firebase

// responsible for
    // functionality to auth user
    // update UI when needed
    //form validation
    // networking

    //error message

class AuthViewModel : ObservedObject {
    @Published var userSession : FirebaseAuth.User
}

