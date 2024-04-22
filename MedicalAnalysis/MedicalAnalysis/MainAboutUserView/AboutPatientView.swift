//
//  AboutPatientView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 22.04.2024.
//


import Foundation
import SwiftUI

struct AboutPatientView: View {
    @State var userAgreed = true
    let patientModel: PatientModel = PatientModel(name: "Макс Пейн", age: "25", lastDateUse: "05.04.2024")
    var body: some View {
        NavigationStack {
            List {
                PatientCell(model: patientModel)
            }.scrollDisabled(true)
            NavigationStack {
                List {
                    NavigationLink(destination: MenuView(withMedcard: false)) {
                        Label("Медицинские данные", systemImage: "list.bullet.rectangle.portrait")
                            .padding()
                    }
                    NavigationLink(destination: UploadNewMedDataView()) {
                        Label("Обновить данные", systemImage: "arrow.clockwise.icloud")
                            .padding()
                    }
                    NavigationLink(destination: StepBarView()) {
                        Label("О приложении", systemImage: "info.square")
                            .padding()
                    }
                }
                .fontWeight(.bold)
                .scrollDisabled(true)
                .listStyle(.plain)
                .frame(minHeight: UIScreen.main.bounds.height / 1.7)
                Text("app version: 1.00")
                    .padding([.bottom], 10)
                    .foregroundStyle(.gray)
            }.navigationTitle("Главная")
        }
    }
}
#Preview {
    AboutPatientView()
}
