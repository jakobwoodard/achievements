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
        NavigationStack {
            ScrollView {
                ForEach(postsGetter.posts) { post in
                    // TODO: Make better view for destination of post
                    NavigationLink(destination: PostView(post: post)) {
                        PostView(post: post)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke()
                    )
                    .padding(.horizontal, 3)
                }
            }
            .navigationTitle("Achievements")
            .toolbar {
                NavigationLink(destination: PostingView(postText: "")) {
                    Text("Post")
                }
                .buttonStyle(.bordered)
                .accessibilityLabel("Post new achievement")
            }
            .task {
                do {
                    await postsGetter.get()
                    // print(postsGetter.posts)
                }
            }
            
        }
    }
    
    @MainActor
    class PostsGetter: ObservableObject {
        @Published var posts = [Post]()
        
        func get() async {
            // clear array so no dup posts
            posts = []
            let db = Firestore.firestore()
            do {
                let querySnapshot = try await db.collection("Posts").order(by: "dateNumeric", descending: true).getDocuments()
                for doc in querySnapshot.documents {
                    posts.append(Post(text: doc.data()["post"] as! String, user: doc.data()["user"] as! String, datePosted: doc.data()["dateFormatted"] as! String))
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
