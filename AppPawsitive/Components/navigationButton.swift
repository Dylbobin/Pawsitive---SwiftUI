//
//  navigationButton.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/24/24.
//

import SwiftUI

struct navigationButton: View {
    let imageName : String
    let title : String
    let imageLead : CGFloat
    let textTrail : CGFloat
    
    var body: some View {
        ZStack {
            Button {
                print("Navigating user to ____ Screen")
            } label: {
                VStack(alignment: .leading) {
                    Text(title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(Font.system(size: 20))
                        .padding(.top, 20)
                        .padding(.trailing, textTrail)
                    Spacer()
                    Image(systemName: imageName)
                        .font(Font.system(size: 40))
                        .foregroundColor(.white)
                        .padding(.bottom, 15)
                        .padding(.leading, imageLead)
                }
            }
        }
        .frame(width: 160, height: 130)
        .background(Color(red: 149/255.0, green: 146/255.0, blue: 166/255.0))
        .cornerRadius(20)
    }
}

#Preview {
    navigationButton(imageName: "square.fill", title: "Dog Parks", imageLead : 90, textTrail: 20)
}
