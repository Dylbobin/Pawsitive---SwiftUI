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
    let tabIndex: Int = 1
    @Binding var selection : Int
    
    init(imageName: String, title: String, imageLead: CGFloat, textTrail: CGFloat, selection: Binding<Int>) {
        self.imageName = imageName
        self.title = title
        self.imageLead = imageLead
        self.textTrail = textTrail
        self._selection = selection
    }
    
    var body: some View {
        ZStack {
            Button {
                print("Navigating user to ____ Screen")
                selection = tabIndex
                print(selection)
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
/*
 #Preview {
 let selection = Binding.constant(1)
 navigationButton(imageName: "square.fill", title: "Dog Parks", imageLead : 90, textTrail: 20, selection: selection)
 }
 */
