//
//  CustomTextField.swift
//  APICall
//
//  Created by Hendrik Steen on 11.02.22.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var value: String
    var title: String
    var body: some View {
        TextField(title, text: $value)
            .disableAutocorrection(true)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15).stroke().foregroundColor(.black).opacity(0.5))
            .frame(width: UIScreen.main.bounds.width - 105)
            .padding()
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(value: .constant("Text"), title: "email")
    }
}
