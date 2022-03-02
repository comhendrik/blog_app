//
//  ContentView.swift
//  APICall
//
//  Created by Hendrik Steen on 06.06.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var avm = AuthViewModel()
    @ObservedObject var pvm = PostViewModel()
    @State private var authCreateValue = "SignIn"
    @State private var showAuthCreate = false
    var body: some View {
        ZStack {
            Color("#354152")
                .ignoresSafeArea(.all)
            VStack {
                Text("Welcome BlogAPI")
                    .fontWeight(.bold)
                    .padding(5)
                if avm.mainAccountID != 0 {
                    Text("Logged in as \(avm.mainAccountUsername)")
                        .fontWeight(.bold)
                        .padding(5)
                }
                
                    
                HStack {
                    Button(action: {
                        if avm.mainAccountID != 0 {
                            avm.logOut()
                        } else {
                            authCreateValue = "SignIn"
                                showAuthCreate.toggle()
                        }
                    }, label: {
                        Text(avm.mainAccountID != 0 ? "Logout": "SignIn")
                            .underline()
                    })
                    Button(action: {
                        if avm.mainAccountID != 0 {
                            authCreateValue = "Create"
                        } else {
                            authCreateValue = "SignUp"
                            
                        }
                        showAuthCreate.toggle()
                    }, label: {
                        Text(avm.mainAccountID != 0 ? "Create": "SignUp")
                            .underline()
                    })
                    
                }
                .foregroundColor(.white)
                PostView(allBlogPosts: pvm.allBlogPosts)
                    .sheet(isPresented: $showAuthCreate, content: {
                        AuthCreateView(viewTitle: authCreateValue,
                                       firstField: (authCreateValue == "Create" ? $pvm.blogPostTitle : $avm.username),
                                       placeholderFirstField: (authCreateValue == "Create" ? "title" : "username"),
                                       secondField: (authCreateValue == "Create" ? $pvm.blogPostBody : $avm.password),
                                       placeholderSecondField: (authCreateValue == "Create" ? "body" : "password"),
                                       action: {
                            if authCreateValue == "SignIn" {
                                avm.signIn()
                            } else if authCreateValue == "SignUp" {
                                avm.signUp()
                            } else {
                                pvm.createPost(with: avm.mainAccountUsername)
                            }
                        },
                                       showView: $showAuthCreate,
                                       showAlert: (authCreateValue == "Create" ? $pvm.showAlert : $avm.showAlert),
                                       alertMsg: (authCreateValue == "Create" ? pvm.alertMsg : avm.alertMsg))

                    })
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
