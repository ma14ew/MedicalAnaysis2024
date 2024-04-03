//
//  ML.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 03.04.2024.
//

import Foundation
import CoreML


class ML {
    
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


