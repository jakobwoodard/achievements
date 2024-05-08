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
        VStack(alignment: .leading) {
            Text(post.user)
                .font(.headline)
                .accessibilityAddTraits(/*@START_MENU_TOKEN@*/.isHeader/*@END_MENU_TOKEN@*/)
            Spacer()
            Text(post.text)
            Spacer()
            HStack {
                Label("\(post.datePosted)", systemImage: "clock")
                    .accessibilityLabel("\(post.datePosted) date posted")
            }
            .font(.caption)
        }
    }
}

#Preview {
    PostView(post: Post.samplePost)
}
