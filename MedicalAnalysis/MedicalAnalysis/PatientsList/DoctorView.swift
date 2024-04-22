//
//  DoctorView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 13.03.2024.
//

import Foundation
import SwiftUI

struct PatientModel {
    var name: String?
    var age: String?
    var lastDateUse: String?
    var id = UUID()
    var diabetData: DiabetPredictModelNew?
}

struct DoctorModel {
    var name: String?
    var photo: Image?
    var doctorPosition: String?
    var organization: String?
    var id = UUID()
}

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
                    NavigationLink(destination: MenuView()) {
                        PatientCell(model: string)
                    }
                }
            }.navigationTitle("Пациенты")
                .listRowSpacing(20)
        }
    }
}

//#Preview {
//    //    PatientCell(model: PatientModel(name: "Матвей Матюшко", age: "23", lastDateUse: "19.02.2024"))
//    DoctorView()
//}



struct PatientCell: View {
    //    let model: PatientModel = PatientModel(name: "Матвей Матюшко", age: "23", lastDateUse: "19.02.2024")
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

struct DoctorCell: View {
    let model: DoctorModel
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .foregroundColor(.gray)
                .frame(maxWidth: 40, maxHeight: 40)
            VStack(alignment: .leading) {
                Text(model.name ?? "")
                Text(model.doctorPosition ?? "")
                Spacer()
                Text(model.organization ?? "")
            }.padding()
                .fontWeight(.bold)
        }
    }
}

struct AboutUserView: View {
    @State var userAgreed = true
    let doctorModel: DoctorModel = DoctorModel(name: "Филипп Преображенский", doctorPosition: "Хирург", organization: "МедЭксперт")
    var body: some View {
        NavigationStack {
            List {
                DoctorCell(model: doctorModel)
            }.scrollDisabled(true)
            NavigationStack {
                List {
                    NavigationLink(destination: PatientListView()) {
                        Label("Пациенты", systemImage: "list.bullet.rectangle.portrait")
                            .padding()
                    }
                    NavigationLink(destination: StepBarView()) {
                        Label("О приложении", systemImage: "questionmark")
                            .padding()
                    }
                }                
                .fontWeight(.bold)
                .scrollDisabled(true)
                .listStyle(.plain)
                .frame(minHeight: UIScreen.main.bounds.height / 1.9)
                Text("app version: 1.00")
                    .padding([.bottom], 10)
                    .foregroundStyle(.gray)
            }.navigationTitle("Главная")
        }
    }
}


#Preview {
    //    PatientCell(model: PatientModel(name: "Матвей Матюшко", age: "23", lastDateUse: "19.02.2024"))
    AboutUserView()
}
