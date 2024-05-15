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
    var body: some View {
        NavigationStack{
            PersonsData(workModel: workModel,
                        model: workModel.modelsView, 
                        modelMl: workModel.models[1])
        }.navigationTitle("Медкарта")
            .onAppear() {
                workModel.makeData()
            }
    }
}


struct PersonsData: View {
    @ObservedObject var workModel = HealthStore()
    @State var model: DiabetPredictModelNewView
    @State var modelMl: DiabetPredictModelNew
    @State var diabString: String = "Нажмите для рассчета"
    @State var isEdit = false
    var body: some View {
        List {
            if isEdit {
                InfoItem(nameOfItem: "Пол",
                         value: model.gender ?? "")
                InfoItem(nameOfItem: "Возраст",
                         value: model.age ?? "")
                InfoItem(nameOfItem: "Наличие гипертонии",
                         value: model.hypertension ?? "")
                InfoItem(nameOfItem: "Наличие сердечных заболеваний",
                         value: model.heart_disease ?? "")
                InfoItem(nameOfItem: "Индекс массы тела",
                         value: model.bmi ?? "")
                InfoItem(nameOfItem: "Глюкоза",
                         value: model.hb ?? "")
                InfoItem(nameOfItem: "Сахар",
                         value: model.blood ?? "")
                InfoItemWithButton(workModel: workModel,
                                   model: modelMl,
                                   nameOfItem: "Показания",
                                   diabString: diabString)
            } else {
                InfoItemWithTextField(nameOfItem: "Пол",
                                      value: model.gender ?? "")
                InfoItemWithTextField(nameOfItem: "Возраст",
                                      value: model.age ?? "")
                InfoItemWithTextField(nameOfItem: "Наличие гипертонии",
                                      value: model.hypertension ?? "")
                InfoItemWithTextField(nameOfItem: "Наличие сердечных заболеваний",
                                      value: model.heart_disease ?? "")
                InfoItemWithTextField(nameOfItem: "Индекс массы тела",
                                      value: model.bmi ?? "")
                InfoItemWithTextField(nameOfItem: "Глюкоза",
                                      value: model.hb ?? "")
                InfoItemWithTextField(nameOfItem: "Сахар",
                                      value: model.blood ?? "")
            }
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

struct InfoItemWithTextField: View {
    let nameOfItem: String
    @State var value: String
    var body: some View {
        VStack(alignment: .leading,
               spacing: 5) {
            Text("\(nameOfItem)")
                .foregroundStyle(.gray)
            TextField("", text: $value)

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
