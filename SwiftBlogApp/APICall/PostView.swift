//
//  PostView.swift
//  APICall
//
//  Created by Hendrik Steen on 10.02.22.
//

import SwiftUI

struct PostView: View {
    var allBlogPosts: [BlogPost] = []
    var body: some View {
        ScrollView {
            ForEach(allBlogPosts) { post in
                BlogPostDetail(blogPost: post)
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(allBlogPosts: [])
    }
}
