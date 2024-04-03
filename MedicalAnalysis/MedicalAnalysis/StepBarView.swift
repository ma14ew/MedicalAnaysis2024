//
//  StepBarView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 03.04.2024.
//

import Foundation
import SwiftUI

struct StepBarView: View {
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
