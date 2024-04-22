//
//  MenuView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 18.04.2024.
//

import Foundation
import SwiftUI


struct MenuView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: DiabetPredictView()) {
                    Label("Медкарта", systemImage: "list.bullet.clipboard")
                        .padding()
                }
                NavigationLink(destination: StepBarView()) {
                    Label("Активность", systemImage: "figure.run")
                        .padding()
                }
                NavigationLink(destination: StepBarView()) {
                    Label("Динамика веса", systemImage: "w.square")
                        .padding()
                }
                NavigationLink(destination: StepBarView()) {
                    Label("Давление", systemImage: "heart.text.square")
                        .padding()
                }
                NavigationLink(destination: StepBarView()) {
                    Label("Сахар в крови", systemImage: "ivfluid.bag")
                        .padding()
                }
            }.listRowSpacing(20)
            .navigationTitle("Меню")
            .fontWeight(.bold)
        }
    }
}


#Preview {
    MenuView()
}
