//
//  Model.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 09.01.2024.
//

import Foundation

struct Step: Identifiable {
    let id = UUID()
    let count: Int
    //    let date: Date
    let date: String
}

struct StepApiModel {
    let userId: String
    let stepsInDay: [Int: String]
}

struct MedCardApiModel {
    let userId: String
    let name: String
    let gender: String
    let age: String
    let hypertension: String
    let heart_disease: String
    let bmi: String
    let hb: String
    let blood: String
}
