//
//  CreatePostViw.swift
//  APICall
//
//  Created by Hendrik Steen on 10.02.22.
//

import SwiftUI

struct CreatePostView: View {
    @ObservedObject var pvm: PostViewModel
    var username: String?
    var body: some View {
        VStack {
            HStack {
                Text("Create")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            CustomTextField(value: $pvm.blogPostTitle, title: "Title")
            CustomTextField(value: $pvm.blogPostBody, title: "Body")
            Spacer()
            Text("Your post will look like this:")
            BlogPostDetail(blogPost: BlogPost(id: 0, title: pvm.blogPostTitle, body: pvm.blogPostBody, user: username ?? "No user"))
                .lineLimit(3)
                .padding()
                .border(.black, width: 2)
                .padding(.vertical)
            Button(action: {
                pvm.createPost(with: username)
            }, label: {
                HStack {
                    Image(systemName: "highlighter")
                    Text("Create")
                }
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(25)
            })
                .alert(isPresented: $pvm.showAlert, content: {
                    Alert(
                        title: Text("Look what happens"),
                        message: Text(pvm.alertMsg),
                        dismissButton: .default(Text("Got it!"))
                    )
                })
        }
        .padding()
    }
}

struct CreatePostView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePostView(pvm: PostViewModel(), username: "Hendrik")
    }
}
