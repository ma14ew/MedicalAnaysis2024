//
//  DiabetPredictView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 03.04.2024.
//

import Foundation
import SwiftUI

enum Persons: String, CaseIterable, Identifiable {
    case Patient1, Patient2, Patient3
    var id: Self { self }
}

struct DiabetPredictView: View {
    @ObservedObject var workModel = HealthStore()
    @State var models = [DiabetPredictModelNew(gender: "Female",
                                               age: 64,    // 1
                                               hypertension: 0,
                                               heart_disease: 0,
                                               bmi: 39.0,
                                               hb: 8.8,
                                               blood: 220),
                         DiabetPredictModelNew(  gender: "Female",
                                                 age: 59,  // 1
                                                 hypertension: 1,
                                                 heart_disease: 0,
                                                 bmi: 32.24,
                                                 hb: 6.5,
                                                 blood: 220),
                         DiabetPredictModelNew(gender: "Male",
                                               age: 56,   // 1
                                               hypertension: 1,
                                               heart_disease: 0,
                                               bmi: 31.77,
                                               hb: 6.1,
                                               blood: 140)
    ]
    @State var selectedModel: Persons = .Patient1
    var body: some View {
        VStack {
            Picker("Выбор человека",
                   selection: $selectedModel) {
                ForEach(Persons.allCases) { model in
                    Text(model.rawValue.capitalized)
                }
            }.pickerStyle(.segmented)
            switch selectedModel {
            case .Patient1:
                PersonsData(workModel: workModel,
                            model: models[0])
            case .Patient2:
                PersonsData(workModel: workModel,
                            model: models[1])
            case .Patient3:
                PersonsData(workModel: workModel,
                            model: models[2])
            }
           
        }.frame(width: 300)
    }
}


struct PersonsData: View {
    @ObservedObject var workModel = HealthStore()
    @State var model: DiabetPredictModelNew
    @State var diabString: String = "-"
    var body: some View {
        Text("Пол - \(model.gender)")
        Text("Возраст - \(String(model.age))")
        Text("hypertension - \(String(model.hypertension))")
        Text("heart_disease - \(String(model.heart_disease))")
        Text("bmi - \(String(model.bmi))")
        Text("hb - \(String(model.hb))")
        Text("blood - \(String(model.blood))")
        Text("Результат - \(diabString)")
        Button(action: {
            diabString = String(workModel.predictMLExt(model: model))
            if diabString == "1" {
                diabString = "есть подозрение"
            } else {
                diabString = "подозрений нет"
            }
        }, label: {
            Text("Предсказать")
        })
    }
}
