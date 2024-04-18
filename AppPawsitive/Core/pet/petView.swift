//
//  petView.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 4/17/24.
//

import SwiftUI

struct petView: View {
    @Binding var showingPet : Bool
    
    var body: some View {
        VStack() {
            HStack {
                Spacer()
                Button {
                    showingPet = false
                } label: {
                    Text("Back")
                        .font(.system(size: 16))
                }
                .foregroundColor(.red)
                .padding(.trailing, 15)
            }
            Text("This is the pet view")
        }
    }
}

#Preview {
    petView(showingPet: .constant(false))
}
