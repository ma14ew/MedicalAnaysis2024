//
//  AboutDoctorView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 22.04.2024.
//

import Foundation
import SwiftUI

struct AboutDoctorView: View {
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
                        Label("О приложении", systemImage: "info.square")
                            .padding()
                    }
                }
                .fontWeight(.bold)
                .scrollDisabled(true)
                .listStyle(.plain)
                .frame(minHeight: UIScreen.main.bounds.height / 1.8)
                Text("app version: 1.00")
                    .padding([.bottom], 10)
                    .foregroundStyle(.gray)
            }.navigationTitle("Главная")
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


#Preview {
    AboutDoctorView()
}
