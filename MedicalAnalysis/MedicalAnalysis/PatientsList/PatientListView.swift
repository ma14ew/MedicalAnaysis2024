//
//  PatientListView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 13.03.2024.
//

import Foundation
import SwiftUI

struct PatientListView: View {
    let model: [PatientModel] = [PatientModel(name: "Макс Пейн",
                                              age: "23 года",
                                              lastDateUse: "19.02.2024",
                                              diabetData: DiabetPredictModelNew(gender: "Male",
                                                                                age: 56,   // 1
                                                                                hypertension: 1,
                                                                                heart_disease: 0,
                                                                                bmi: 31.77,
                                                                                hb: 6.1,
                                                                                blood: 140)),
                                 PatientModel(name: "Сергей Нечаев",
                                              age: "23 года",
                                              lastDateUse: "19.02.2024"),
                                 PatientModel(name: "Артем Черный",
                                              age: "23 года",
                                              lastDateUse: "19.02.2024"),
                                 PatientModel(name: "Алан Вейк",
                                              age: "23 года",
                                              lastDateUse: "19.02.2024")]


    var body: some View {
        NavigationStack {
            List {
                ForEach(model, id: \.id) { string in
                    NavigationLink(destination: MenuView(withMedcard: true)) {
                        PatientCell(model: string)
                    }
                }
            }.navigationTitle("Пациенты")
                .listRowSpacing(20)
        }
    }
}


struct PatientCell: View {
    let model: PatientModel
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .foregroundColor(.gray)
                .frame(maxWidth: 40, maxHeight: 40)
            VStack(alignment: .leading) {
                Text(model.name ?? "")
                HStack {
                    Text(model.age ?? "")
                    Text(model.lastDateUse ?? "")
                }
            }.padding()
                .fontWeight(.bold)
        }
    }
}

#Preview {
    PatientListView()
}
