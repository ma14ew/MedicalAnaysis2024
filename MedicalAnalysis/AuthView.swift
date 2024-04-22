//
//  AuthView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 22.04.2024.
//

import Foundation
import SwiftUI

struct AuthView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowingAlert: Bool = false

    var body: some View {
        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
        VStack() {
            TextField("Имя пользователя", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)

            SecureField("Пароль", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
        }
        .padding([.top, .bottom], 50)

            Button(action: {
                self.login()
            }) {
                NavigationLink(destination: AboutDoctorView()) {
                Text("Войти")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
        Spacer()
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("Error"), message: Text("Invalid username or password"), dismissButton: .default(Text("OK")))
        }
    }

    func login() {
        if username == "admin" && password == "password" {
            print("Login successful")

        } else {
            isShowingAlert = true
        }
    }
}

#Preview {
    AuthView()
}

