//
//  petSelector.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/24/24.
//

import SwiftUI

struct petSelector: View {
    @State private var selectedPet: String = "" // State to hold the selected pet
    
    var body: some View {
        VStack {
            HStack {
                Text("Select Pet: ")
                    .fontWeight(.semibold)
                    .padding(30)
                    .foregroundColor(.white)
                    .font(Font.system(size: 12))
                    .clipped()
                
                Spacer()
                
                // Use Spacer() to push the Picker to the right
                //Spacer()
                
                Picker(selection: $selectedPet, label: Text("")) {
                    Text("Dogggggggg").tag("Dog")
                    Text("Cat").tag("Cat")
                    Text("Bird").tag("Bird")
                    // Add more pet options as needed
                }
                .pickerStyle(MenuPickerStyle()) // Style the picker as a dropdown menu
                .accentColor(.white) // Set accent color to white
                .frame(width: 150)
                .clipped()
                
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width - 64, height: 48) // Adjust the frame width
            
            //.background(Color(red: 185/255, green: 183/255, blue: 196/255))
            .background(Color(red: 75/255.0, green: 200/255.0, blue: 135/255.0))
            .cornerRadius(24)
            .padding(.top, 24)
        }
        .padding()
    }
}



#Preview {
    petSelector()
}

