//
//  userData.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/10/24.
//

import Foundation

// created to make a user data object
// these will eb referred to to populate profile user data

struct User : Identifiable, Codable {
    let id : String
    let fullName : String
    let email : String
    
    
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        // could possibly return a blank image here
        return ""
    }
    
    var firstName: String {
        // split name by spaces
        let components = fullName.split(separator: " ")
        
        // first component as the first name
        if let firstName = components.first {
            return String(firstName)
        }
        
        // If there is no first name, return an empty string
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Test Example", email: "test@example.com")
}

