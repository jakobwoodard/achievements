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
            .alert("Posted", isPresented: $isPresentingAlert) {
            }
        }
    }
    
    func sendPost() {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Posts").document()
        let docData: [String:Any] = [
            "post": postText,
            "dateAdded": (Date().formatted()),
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

#Preview {
    PostingView(postText: "").environmentObject(FirebaseManager())
}


