//
//  signButton.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/5/24.
//

import SwiftUI

struct signButton: View {
    @Binding var action : String
    var title: String
    var body: some View {
        Button {
            print(action)
        } label: {
            HStack {
                Text(title)
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
    }
}

#Preview {
    signButton(action: .constant(""), title : "Sign In")
}

