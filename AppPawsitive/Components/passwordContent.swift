//
//  passwordContent.swift
//  AppPawsitive
//
//  Created by Dylan Silva on 2/15/24.
//

// unused, left it as is and hard coded
import SwiftUI

struct passwordContent: View {
    @State var hasUpper : Bool
    @State var hasNumber : Bool
    @State var hasLength : Bool
    
    var body: some View {
        HStack(spacing: 10) {
            
            HStack(alignment: .firstTextBaseline){
                if !hasUpper {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.systemRed))
                        .imageScale(.small)
                } else {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(.systemGreen))
                        .imageScale(.small)
                }
                Text("Uppercase Letter")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .foregroundColor(Color(.darkGray))
            }
            HStack(alignment: .firstTextBaseline) {
                if !hasNumber {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.systemRed))
                        .imageScale(.small)
                } else {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(.systemGreen))
                        .imageScale(.small)
                }
                Text("Number")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .foregroundColor(Color(.darkGray))
            }
            HStack(alignment: .firstTextBaseline) {
                if !hasLength {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(.systemRed))
                        .imageScale(.small)
                } else {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color(.systemGreen))
                        .imageScale(.small)
                }
                Text("Length")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .foregroundColor(Color(.darkGray))
            }
        }
    }
}

#Preview {
    passwordContent(hasUpper: false, hasNumber: false, hasLength: false)
}
