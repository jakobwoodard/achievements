//
//  Post.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: UUID
    var text: String
    var user: String
    var datePosted: String
    
    init(id: UUID = UUID(), text: String, user: String, datePosted: String) {
        self.id = id
        self.text = text
        self.user = user
        self.datePosted = datePosted
    }
    
}


extension Post {
    static let samplePost: Post = Post(text: "Sample Post", user: "Sample User 1", datePosted: Date().formatted())
}
