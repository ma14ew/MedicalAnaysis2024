//
//  DiabetPredictModel.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 22.04.2024.
//

import Foundation

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

struct DiabetPredictModelNewView {
    var gender: String?
    var age: String?
    var hypertension: String?
    var heart_disease: String?
    var bmi: String?
    var hb: String?
    var blood: String?
}
