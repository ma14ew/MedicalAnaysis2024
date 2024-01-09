//
//  ContentView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 08.01.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = HealthStore()
    var body: some View {
        BarMarkChart(model: model)
        .padding()
        .task {
            await model.requestAuthorization()
            do {
                try await model.calculateSteps()
                print(model.steps)
            } catch {
                print("error")
            }
        }
    }
}

#Preview {
    ContentView()
}
