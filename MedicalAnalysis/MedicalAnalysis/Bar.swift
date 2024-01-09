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
                Text("Количество шагов по дням недели")
                    .font(.system(.largeTitle, weight: .semibold))
                VStack {
                    Chart {
                        ForEach(model.steps) { step in
                            BarMark(
                                x: .value("День недели", step.date),
                                y: .value("Дистанция", step.count)
                            )
                        }.foregroundStyle(.orange)
                    }
                }.frame(height: 300)
                Text("Подсчет шагов - количество шагов, сделанных Вами за день. Шагомеры и цифровые трекеры активности могут помочь Вам в подсчете шагов. Эти устройства подсчитывают шаги при любой активности, похожей на шагание: ходьбе, беге, подьеме по лестнице, катании на беговых лыжах и даже движении при повседневных домашних делах.")
            }
        }
    }
}

struct LineMarkChart: View {
    @ObservedObject var model: HealthStore
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Вес")
                    .font(.system(.largeTitle, weight: .semibold))
                VStack {
                    Chart {
                        ForEach(model.steps) { step in
                            Plot {
                                LineMark(
                                    x: .value("День недели", step.date),
                                    y: .value("Вес", step.date)
                                )
                                PointMark(
                                    x: .value("День недели", step.date),
                                    y: .value("Вес", step.date)
                                )
                            }.foregroundStyle(.purple)
                        }
                    }
                }.frame(height: 600)
            }
        }
    }
}
