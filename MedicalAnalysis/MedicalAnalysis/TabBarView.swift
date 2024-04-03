//
//  TabBarView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 03.04.2024.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView() {
            StepBarView()
                .tabItem {Text("график")}
            DiabetPredictView()
                .tabItem {Text("Predict")}
        }
    }
}
