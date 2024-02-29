//
//  ContentView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 08.01.2024.
//

import SwiftUI

struct DiabetPredictModel {
    var age: String
    var bmi: String
    var hb: String
    var blood: String
}

struct TabBar: View {
    var body: some View {
        TabView() {
            StepBarView()
                .tabItem {Text("график")}
            DiabetPredict()
                .tabItem {Text("Predict")}
        }
    }
}

struct StepBarView: View {
    @ObservedObject var model = HealthStore()
    var body: some View {
            BarMarkChart(model: model)
        .padding()
        .task {
            await model.requestAuthorization()
            do {
                try await model.calculateSteps()
                print(model.steps)
            } catch {
                print("error")
            }
        }
        .onAppear() {
//            model.predictML()
        }
    }
}

struct DiabetPredict: View {
    @ObservedObject var workModel = HealthStore()
    @State var model = DiabetPredictModel(age: "", bmi: "", hb: "", blood: "")
    @State var diabString: String = "-"
    var body: some View {
        VStack {
            TextField("Возраст", text: $model.age)
                .textFieldStyle(.roundedBorder)
            TextField("BMI", text: $model.bmi)
                .textFieldStyle(.roundedBorder)
            TextField("HB", text: $model.hb)
                .textFieldStyle(.roundedBorder)
            TextField("Blood", text: $model.blood)
                .textFieldStyle(.roundedBorder)
            Text(diabString)
            Button(action: {
               diabString = String(workModel.predictML(model: model))
            }, label: {
                Text("Predict")
            })
        }.frame(width: 300)
    }
}

#Preview {
    TabBar()
}
