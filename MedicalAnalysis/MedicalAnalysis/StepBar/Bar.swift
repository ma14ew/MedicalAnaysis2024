//
//  Bar.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 08.01.2024.
//

import Foundation
import SwiftUI
import Charts

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

