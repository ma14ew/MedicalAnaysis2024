//
//  MedicalAnalysisApp.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 08.01.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct MedicalAnalysisApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
//            MenuView(withMedcard: true)
//            AuthView()
//            AuthViewLogin()
            DiabetPredictView()
        }
    }
}

