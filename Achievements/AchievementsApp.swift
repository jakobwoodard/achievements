//
//  AchievementsApp.swift
//  Achievements
//
//  Created by Jakob Woodard on 5/3/24.
//

import SwiftUI
import FirebaseCore
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct AchievementsApp: App {
  // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var firestoreManager = FirebaseManager()
    var body: some Scene {
        WindowGroup {
            NavigationView {
//                ContentView().environmentObject(firestoreManager)
                FeedView()
            }
        }
    }
}
