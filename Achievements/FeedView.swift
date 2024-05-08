//
//  FeedView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct FeedView: View {
    @State var posts = [Post]()
    var body: some View {
        VStack {
            Text(posts[0].text)
        }
        .onAppear {
            getPosts { posts in
                self.posts = posts
            }
        }
    }
    
    
    
    func getPosts(completionHanlder: ([Post]) -> Void) {
        let db = Firestore.firestore()
        db.collection("Posts").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting posts: \(error)")
            }
            else {
                for document in querySnapshot!.documents {
                    let newPost = Post(text: document.data()["text"] as? String ?? "",
                                       user: document.data()["user"] as? String ?? "",
                                       datePosted: document.data()["dateAdded"] as? String ?? "")
                    self.posts.append(newPost)
                }
            }
        }
        completionHanlder(posts)
    }
}

#Preview {
    FeedView(posts: [Post.samplePost])
}
