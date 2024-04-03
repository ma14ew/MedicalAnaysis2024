//
//  DoctorView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 13.03.2024.
//

import Foundation
import SwiftUI

struct PatientModel {
    var name: String?
    var age: String?
    var lastDateUse: String?
    var id = UUID()
}

struct DoctorView: View {
    let model: [PatientModel] = [PatientModel(name: "Матвей Матюшко", age: "23", lastDateUse: "19.02.2024"),
                                 PatientModel(name: "Артемий Поповский"),
                                 PatientModel(name: "Лауренсия Ахмедова"),
                                 PatientModel(name: "Ольга Матюшко")]
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Пациенты")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                List {
                    ForEach(model, id: \.id) { string in
                        PatientCell(model: string)
                            .onTapGesture {
                                print("DetailView")
                            }
                    }
                }
            }
        }
    }
}

#Preview {
//    PatientCell(model: PatientModel(name: "Матвей Матюшко", age: "23", lastDateUse: "19.02.2024"))
    DoctorView()
}



struct PatientCell: View {
//    let model: PatientModel = PatientModel(name: "Матвей Матюшко", age: "23", lastDateUse: "19.02.2024")
    let model: PatientModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.name ?? "")
            HStack {
                Text(model.age ?? "")
                Text(model.lastDateUse ?? "")
            }
        }
    }
}
