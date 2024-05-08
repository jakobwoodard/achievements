//
//  ContentView.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var firestoreManager: FirebaseManager
    var body: some View {
        Text("My restaurant:")
                .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FirebaseManager())
    }
    
}
