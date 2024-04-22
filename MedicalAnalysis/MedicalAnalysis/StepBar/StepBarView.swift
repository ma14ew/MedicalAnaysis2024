//
//  StepBarView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 03.04.2024.
//

import Foundation
import SwiftUI
import Charts

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

struct BarMarkChart: View {
    @ObservedObject var model: HealthStore
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                VStack {
                    if !model.steps.isEmpty {
                        Chart {
                            ForEach(model.steps) { step in
                                BarMark(
                                    x: .value("День недели", step.date),
                                    y: .value("Дистанция", step.count)
                                )
                            }.foregroundStyle(.orange)
                        }
                    } else {
                        VStack(alignment: .center) {
                            Text("Данных о активности не найдено")
                        }
                    }
                }.frame(height: 300)
            }
        }
    }
}


