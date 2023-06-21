//
//  CatApplicationApp.swift
//  CatApplication
//
//  Created by Andrii Sulimenko on 17.05.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct CatApplicationApp: App {    
    @StateObject private var viewModel = CatStorage()
    @State private var permissionNotification = !UserDefaults.standard.bool(forKey: "permissionReceived")
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            CatList()
                .environmentObject(viewModel)
                .alert(
                    "Permission for data collecting",
                    isPresented: $permissionNotification,
                    actions: {
                        Button("Yes") {
                            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
                            UserDefaults.standard.set(true, forKey: "permissionReceived")
                        }
                        Button("No") {
                            Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
                            UserDefaults.standard.set(true, forKey: "permissionReceived")
                        }
                    }, message: {
                        Text("Would you like to share reports about program crashes?")
                    })
        }
    }
}
