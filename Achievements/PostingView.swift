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
        NavigationStack {
            Form {
                // TODO: Implement custom TextView class to have multi-line
                // text prompt
                TextField(text: $postText, prompt: Text("Required")) {
                }
            }
            .alert(isPresented: $isPresentingAlert, content: {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Alert(title: Text("Alert"))/*@END_MENU_TOKEN@*/
            })
            .toolbar {
                Button(action: sendPost, label: {
                    Text("Post")
                })
            }
        }
        
        
    }
    
    func sendPost() {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Posts").document()
        let docData: [String:Any] = [
            "post": postText,
            // TODO: Figure out better way to store time so it can be sorted
            // to make feed chronological
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


