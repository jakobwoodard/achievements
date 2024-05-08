//
//  PostView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import SwiftUI
import Firebase

struct PostingView: View {
    @State var postText:String
    @EnvironmentObject var firestoreManager: FirebaseManager
    
    var body: some View {
        VStack {
            Form {
                TextField(text: $postText, prompt: Text("Required")) {
                    }
            }
            Button(action: sendPost) {
                Text("Post")
            }
        }
    }
    
    func sendPost() {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Posts").document("Test User")
        let docData: [String:Any] = [
            "post": postText,
            "dateAdded": Timestamp(date: Date()),
            "user": "User1"
        ]
        docRef.setData(docData) { error in
            if let error = error {
                print("Error posting", error)
            }
            else {
                print("Posted")
            }
        }
    }

}

#Preview {
    PostingView(postText: "").environmentObject(FirebaseManager())
}


