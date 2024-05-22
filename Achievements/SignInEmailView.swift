//
//  SignInEmailView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/22/24.
//

import SwiftUI

@MainActor
final class SignInEmailViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        print("Valid data")
        let returnedUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
        guard returnedUserData != nil else {
            print("Could not create user")
            throw URLError(.badServerResponse)
        }
        print("success")
        print(returnedUserData.debugDescription)
        }
        
    }


struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4))
                .cornerRadius(10)
            
            Button {
                Task {
                    do {
                        print("Sign in")
                        try await viewModel.signIn()
                        showSignInView = false
                    }
                    catch {
                        print("Error making account")
                    }
                }
                
            } label: {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In With Email")
    }
}

struct SignInEmailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignInEmailView(showSignInView: .constant(false))
        }
    }
    
}
