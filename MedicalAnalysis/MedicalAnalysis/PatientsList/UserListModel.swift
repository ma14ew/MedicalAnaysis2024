//
//  UserListModel.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 22.04.2024.
//

import Foundation
import SwiftUI

struct PatientModel {
    var name: String?
    var age: String?
    var lastDateUse: String?
    var id = UUID()
    var diabetData: DiabetPredictModelNew?
}

struct DoctorModel {
    var name: String?
    var photo: Image?
    var doctorPosition: String?
    var organization: String?
    var id = UUID()
}
