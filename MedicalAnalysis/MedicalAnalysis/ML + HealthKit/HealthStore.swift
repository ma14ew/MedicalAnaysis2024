//
//  Health.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 08.01.2024.
//
import Foundation
import HealthKit
import CoreML

class HealthStore: ObservableObject {

    @Published var steps: [Step] = []
    @Published var healthStore: HKHealthStore?
    @Published var models = [DiabetPredictModelNew(gender: "Female",
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
    @Published var modelsView: DiabetPredictModelNewView = DiabetPredictModelNewView()

    func makeData() {
        modelsView = makeDataForView(model: models[0])
    }

    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            print("error")
        }
        modelsView = makeDataForView(model: models[0])
    }

    private func makeSimpleDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "DD-MM"
        return formatter.string(from: date)
    }

    func calculateSteps() async throws {
        guard let healthStore = self.healthStore else { return }

        let calendar = Calendar(identifier: .gregorian)
        let startDate = calendar.date(byAdding: .day, value: -7, to: Date())
        let endDate = Date()

        let stepType = HKQuantityType(.stepCount)
        let everyDay = DateComponents(day: 1)
        let thisWeek = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let stepThisWeek = HKSamplePredicate.quantitySample(type: stepType, predicate: thisWeek)

        let sumOfStepsQuery = HKStatisticsCollectionQueryDescriptor(predicate: stepThisWeek, options: .cumulativeSum, anchorDate: endDate, intervalComponents: everyDay)

        let stepsCount = try await sumOfStepsQuery.result(for: healthStore)

        guard let startDate = startDate else { return }

        stepsCount.enumerateStatistics(from: startDate, to: endDate) { statistic, stop in
            let count = statistic.sumQuantity()?.doubleValue(for: .count())
            let step = Step(count: Int(count ?? 0), date: self.makeSimpleDate(date: statistic.startDate))
            if step.count > 0 {
                DispatchQueue.main.async {
                    self.steps.append(step)
                }
            }
        }
    }

    func requestAuthorization() async {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount) else { return }
        guard let healthStore = self.healthStore else { return }

        do {
            try await healthStore.requestAuthorization(toShare: [], read: [stepType])
        } catch {
            print("2error")
        }
    }

    var mlModel: MlModelForDiplom_1 = try! MlModelForDiplom_1(configuration: .init())

    func predictMLExt(model: DiabetPredictModelNew) -> Int64 {
        guard let mlOutput = try? mlModel.prediction(   gender: model.gender,
                                                        age: model.age,
                                                        hypertension: model.hypertension,
                                                        heart_disease: model.heart_disease,
                                                        bmi: model.bmi,
                                                        HbA1c_level: model.hb,
                                                        blood_glucose_level: model.blood) else {
            fatalError("error")
        }
        return mlOutput.diabetes
    }


    func makeDataForView(model: DiabetPredictModelNew) -> DiabetPredictModelNewView {
        DiabetPredictModelNewView(gender: model.gender == "Women" ? "Женщина" : "Мужчина",
                                  age: String(model.age.rounded(.awayFromZero)),
                                  hypertension: model.hypertension == 1 ? "Да": "Нет",
                                  heart_disease: model.heart_disease == 1 ? "Да": "Нет",
                                  bmi: String(model.bmi),
                                  hb: String(model.hb),
                                  blood: String(model.blood))
    }
}



