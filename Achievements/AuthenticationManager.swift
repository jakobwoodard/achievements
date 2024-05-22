//
//  AuthenticationManager.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/22/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() { }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        return AuthDataResultModel(user: user)
    }
    
    // Creates a new user and returns the user details
    // returns nil if the user cannot be created
    func createUser(email: String, password: String) async throws -> AuthDataResultModel? {
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return AuthDataResultModel(user: authDataResult.user)
        }
        catch {
            print(error)
            return nil
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
}
