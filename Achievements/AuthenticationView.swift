//
//  AuthenticationView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/22/24.
//

import SwiftUI

struct AuthenticationView: View {
    
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
            } label: {
                Text("Sign In with Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(showSignInView: .constant(false))
    }
    
}
