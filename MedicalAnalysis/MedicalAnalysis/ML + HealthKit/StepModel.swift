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
