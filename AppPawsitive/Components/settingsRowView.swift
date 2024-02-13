//
//  settingsRowView.swift
//  Pawsitive
//
//  Created by Dylan Silva on 2/7/24.
//

import SwiftUI

struct settingsRowView: View {
    let imageName : String
    let title : String
    let tintColor : Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    settingsRowView(imageName: "gear", title: "version", tintColor: Color(.systemGray))
}

