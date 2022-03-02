//
//  AuthCreateView.swift
//  APICall
//
//  Created by Hendrik Steen on 13.02.22.
//

import SwiftUI

struct AuthCreateView: View {
    var viewTitle: String
    @Binding var firstField: String
    var placeholderFirstField: String
    @Binding var secondField: String
    var placeholderSecondField: String
    var action: () -> Void
    @Binding var showView: Bool
    @Binding var showAlert: Bool
    var alertMsg: String
    var body: some View {
        ZStack {
            Color("#354152")
                .ignoresSafeArea(.all)
            Rectangle(
            )
                .foregroundColor(Color("#6d756f"))
                .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.height - 300)
                .cornerRadius(25)
            VStack {
                Text(viewTitle)
                CustomTextField(value: $firstField, title: placeholderFirstField)
                CustomTextField(value: $secondField, title: placeholderSecondField)
                Button(action: {
                    action()
                }, label: {
                    Text("Submit")
                        .foregroundColor(.black.opacity(0.5))
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke().foregroundColor(.black).opacity(0.5)
                                    .frame(width: UIScreen.main.bounds.width - 105))
                        .frame(width: UIScreen.main.bounds.width - 105)
                        .padding()
                        
                })
                Button(action: {
                    showView.toggle()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black.opacity(0.5))
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke().foregroundColor(.black).opacity(0.5))
                        .padding()
                        
                })
                    .alert(isPresented: $showAlert, content: {
                        Alert(
                            title: Text("Look what happens"),
                            message: Text(alertMsg),
                            primaryButton: .default(Text("Got it!")),
                            secondaryButton: .destructive(Text("Close View")) {
                                showView.toggle()
                            }
                        )
                    })
            }
        }
    }
}

struct AuthCreateView_Previews: PreviewProvider {
    static var previews: some View {
        AuthCreateView(viewTitle: "Create", firstField: .constant(""), placeholderFirstField: "title", secondField: .constant(""), placeholderSecondField: "body", action: {
            print("Hello World")
        }, showView: .constant(true), showAlert: .constant(false), alertMsg: "")
    }
}
