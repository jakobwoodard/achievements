//
//  AccountView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/13/24.
//

import SwiftUI

@MainActor
final class AccountViewModel: ObservableObject {
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
}

struct AccountView: View {
    
    @StateObject private var viewModel = AccountViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("Log out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView(showSignInView: .constant(false))
    }
    
}
