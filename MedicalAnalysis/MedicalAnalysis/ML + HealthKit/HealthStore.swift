//
//  Health.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 08.01.2024.
//
import Foundation
import HealthKit

class HealthStore: ObservableObject {

    @Published var steps: [Step] = []
    @Published var healthStore: HKHealthStore?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            print("error")
        }
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
    
    var mlModel = MlModelForDiplom_1()
    
    func predictMLExt(model: DiabetPredictModelNew) -> Int64 {
        guard let mlOutput = try? mlModel.prediction(   gender: model.gender ?? "",
                                                        age: model.age ?? 0.0,
                                                        hypertension: model.hypertension ?? 0,
                                                        heart_disease: model.heart_disease ?? 0,
                                                        bmi: model.bmi ?? 0.0,
                                                        HbA1c_level: model.hb ?? 0.0,
                                                        blood_glucose_level: model.blood ?? 0) else {
            fatalError("error")
        }
        return mlOutput.diabetes
    }
}
