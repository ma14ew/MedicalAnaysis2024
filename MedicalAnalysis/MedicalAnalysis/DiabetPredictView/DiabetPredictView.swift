//
//  DiabetPredictView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 03.04.2024.
//

import Foundation
import SwiftUI

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
                                               blood: 140)]
    var body: some View {
        NavigationStack{
            PersonsData(workModel: workModel,
                        model: models[0])
        }.navigationTitle("Медкарта")
    }
}


struct PersonsData: View {
    @ObservedObject var workModel = HealthStore()
    @State var model: DiabetPredictModelNew
    @State var diabString: String = "Нажмите для рассчета"
    var body: some View {
        List {
            InfoItem(nameOfItem: "Пол",
                     value: model.gender)
            InfoItem(nameOfItem: "Возраст",
                     value: String(model.age))
            InfoItem(nameOfItem: "Наличие гипертонии",
                     value: String(model.hypertension))
            InfoItem(nameOfItem: "Наличие сердечных заболеваний",
                     value: String(model.heart_disease))
            InfoItem(nameOfItem: "Индекс массы тела",
                     value: String(model.bmi))
            InfoItem(nameOfItem: "Глюкоза",
                     value: String(model.hb))
            InfoItem(nameOfItem: "Сахар",
                     value: String(model.blood))
            InfoItemWithButton(workModel: workModel,
                               model: model,
                               nameOfItem: "Показания",
                               diabString: diabString)
        }
    }
}

struct InfoItem: View {
    let nameOfItem: String
    var value: String
    var body: some View {
        VStack(alignment: .leading,
               spacing: 5) {
            Text("\(nameOfItem)")
                .foregroundStyle(.gray)
            Text(value)
                .fontWeight(.bold)
        }
    }
}

struct InfoItemWithButton: View {
    @ObservedObject var workModel: HealthStore
    @State var model: DiabetPredictModelNew
    let nameOfItem: String
    @State var diabString: String
    @State var textColor: Color = .blue
    var body: some View {
        VStack(alignment: .leading,
               spacing: 5) {
            Text("\(nameOfItem)")
                .foregroundStyle(.gray)
            Text(diabString)
                .foregroundStyle(textColor)
                .fontWeight(.bold)
                .onTapGesture {
                    diabString = String(workModel.predictMLExt(model: model))
                    if diabString == "1" {
                        diabString = "Есть подозрение ⚡️⚡️⚡️"
                        textColor = .black
                    } else {
                        diabString = "Подозрений нет 👍👍👍"
                        textColor = .black
                    }
                }
        }
    }
}

#Preview {
    DiabetPredictView()
}
