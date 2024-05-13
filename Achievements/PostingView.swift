//
//  PostView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import SwiftUI
import Firebase

struct PostingView: View {
    @State var postText: String
    @State var isPresentingAlert: Bool = false
    @State var alertMsg: String = "Posted"
    @EnvironmentObject var firestoreManager: FirebaseManager
    
    var body: some View {
        NavigationStack {
            Form {
                // TODO: Implement custom TextView class to have multi-line
                // text prompt
                TextField(text: $postText, prompt: Text("Required")) {
                }
            }
            .alert(isPresented: $isPresentingAlert, content: {
                Alert(title: Text(alertMsg))
            })
            .toolbar {
                Button(action: sendPost, label: {
                    Text("Post")
                })
            }
        }
        
        
    }
    
    // Sends the post to Firebase "Posts" Collection
    func sendPost() {
        
        // Error handle the Post
        if (postText.isEmpty || postText == "") {
            alertMsg = "Post can't be blank"
            print("Error: Post was blank")
            return
        }
        
        // If valid, try to send
        else {
            let db = Firestore.firestore()
            
            let docRef = db.collection("Posts").document()
            let docData: [String:Any] = [
                "post": postText,
                // TODO: Figure out better way to store time so it can be sorted
                // to make feed chronological
                "dateNumeric": Date().timeIntervalSince1970,
                "dateFormatted": (Date().formatted(date: .numeric, time: .shortened)),
                "user": "User1"
            ]
            docRef.setData(docData) { error in
                if let error = error {
                    print("Error posting", error)
                }
                else {
                    isPresentingAlert = true
                    postText = ""
                    print("Posted")
                }
            }
        }
    }

}

#Preview {
    PostingView(postText: "", alertMsg: "").environmentObject(FirebaseManager())
}


