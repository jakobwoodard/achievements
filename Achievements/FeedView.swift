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
    @ObservedObject var postsGetter = PostsGetter()
    var body: some View {
        VStack {
            ForEach(postsGetter.posts) { post in
                PostView(post: post)
            }
        }
        .task {
            do {
                await postsGetter.get()
                // print(postsGetter.posts)
            }
        }
    }
    
    @MainActor
    class PostsGetter: ObservableObject {
        @Published var posts = [Post]()
        
        func get() async {
            let db = Firestore.firestore()
            do {
                let querySnapshot = try await db.collection("Posts").getDocuments()
                for doc in querySnapshot.documents {
                    posts.append(Post(text: doc.data()["post"] as! String, user: doc.data()["user"] as! String, datePosted: doc.data()["dateAdded"] as! String))
                }
            }
            catch {
                print("Error getting documents: \(error)")
            }
        }
        
    }
}

#Preview {
    FeedView()
}
