//
//  inputView.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/5/24.
//

import SwiftUI
//reusable input field
struct inputView: View {
    @Binding var text : String
    let title : String
    let placeholder : String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .font(.system(size: 14))
            } else {
                TextField(placeholder, text: $text)
                    .font(.system(size: 14))
            }
            // secondary divider bar
            Divider()
        }
    }
}

#Preview {
    inputView(text: .constant(""), title: "Email Address", placeholder: "name@example.com")
}

