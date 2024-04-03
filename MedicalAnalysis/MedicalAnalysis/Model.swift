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

struct DiabetPredictModelNew {
    var gender: String
    var age: Double
    var hypertension: Int64
    var heart_disease: Int64
    var bmi: Double
    var hb: Double
    var blood: Int64
}

struct DiabetPredictModel {
    var age: String
    var bmi: String
    var hb: String
    var blood: String
}
