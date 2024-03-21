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
    @Binding var searchItem : String
    init(imageName: String, title: String, imageLead: CGFloat, textTrail: CGFloat, selection: Binding<Int>, searchItem: Binding<String>) {
        self.imageName = imageName
        self.title = title
        self.imageLead = imageLead
        self.textTrail = textTrail
        self._selection = selection
        self._searchItem = searchItem
    }
    
    var body: some View {
        ZStack {
            Button {
                switch title {
                case "Hospital":
                    searchItem = "Pet Hospitals"
                case "Dog Park":
                    searchItem = "Dog Parks"
                case "Store":
                    searchItem = "Pet Stores"
                case "All":
                    searchItem = "ALL"
                default:
                    searchItem = ""
                }
                print("Navigating user to \(searchItem) Screen")
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
                        .padding(.leading, 10)
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
        .background(Color(red: 75/255.0, green: 200/255.0, blue: 135/255.0))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 149/255.0, green: 146/255.0, blue: 166/255.0), lineWidth: 1)
        )
    }
}

 #Preview {
     navigationButton(imageName: "square.fill", title: "Dog Parks", imageLead : 90, textTrail: 20, selection: Binding.constant(0), searchItem: Binding.constant(""))
     //navigationButton(imageName: "square.fill", title: "Dog Parks", imageLead : 90, textTrail: 20)
 }
 
 
