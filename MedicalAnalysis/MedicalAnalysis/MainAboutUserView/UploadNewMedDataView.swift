//
//  UploadNewMedDataView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 22.04.2024.
//

import Foundation
import SwiftUI

struct UploadNewMedDataView: View {
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Text("Последнее обновление данных:")
                    Text("19.02.2024 20:53")
                }
                Button("Обновить данные") {

                }.padding()
            }.navigationTitle("Обновить данные")
        }
    }
}

#Preview {
    UploadNewMedDataView()
}
