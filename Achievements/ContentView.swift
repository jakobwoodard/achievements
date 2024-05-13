//
//  ContentView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var firestoreManager: FirebaseManager
    @State var selectedTab: Int = 0 // 0 means home/feed

    var body: some View {
        TabView(selection: $selectedTab) {
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "circle.square.fill")
                }
            .tag(0)
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
            .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirebaseManager())
    }
    
}
