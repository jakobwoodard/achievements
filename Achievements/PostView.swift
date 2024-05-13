//
//  PostView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import SwiftUI

struct PostView: View {
    let post: Post

    var body: some View {
        VStack {
            HStack {
                Text(post.user)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.subheadline)
            .padding()
            Spacer()
            HStack {
                Text(post.text)
            }
            Spacer()
            HStack {
                Label("\(post.datePosted)", systemImage: "clock")
                    .accessibilityLabel("\(post.datePosted) date posted")
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
            
        }
    }
}

#Preview {
    PostView(post: Post.samplePost)
}
