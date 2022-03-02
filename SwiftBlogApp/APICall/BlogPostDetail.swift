//
//  BlogPostDetail.swift
//  APICall
//
//  Created by Hendrik Steen on 10.02.22.
//

import SwiftUI

struct BlogPostDetail: View {
    var blogPost: BlogPost
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(blogPost.title)
                        .font(.title)
                    Text("by \(blogPost.user)")
                        .font(.subheadline)
                    Text(blogPost.body)
                        .padding()
                    
                }
                Spacer()
            }
            .padding()
        }
        .background(Color("#6d756f").cornerRadius(25))
        .padding()
    }
}

struct BlogPostDetail_Previews: PreviewProvider {
    static var previews: some View {
        BlogPostDetail(blogPost: BlogPost(id: 0, title: "Hello", body: "Hello World", user: "Hendrik"))
    }
}
