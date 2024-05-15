//
//  AuthView.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 22.04.2024.
//

import Foundation
import SwiftUI

enum UserRole: String {
    case doctor, patient
    var id: Self { self }
}

struct AuthView: View {
    @ObservedObject var authViewModel = AuthService()

    @State private var login: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var organization: String = ""
    @State private var userRole: String = UserRole.patient.rawValue

    @State private var isShowingAlert: Bool = false
    @State private var selectedRole: UserRole = .doctor

    var body: some View {
        Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
        VStack() {
            TextField("Имя пользователя", text: $login)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            TextField("Имя и Фамилия", text: $name)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            TextField("Название организации", text: $organization)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            Picker("Роль", selection: $selectedRole) {
                Text("Доктор").tag(UserRole.doctor)
                Text("Пациент").tag(UserRole.patient)
            }
            SecureField("Пароль", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
        }
        .padding([.top, .bottom], 50)

        Button(action: {
            self.registerUser()
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

    func registerUser() {
        let user = RegisterUserRequest(login: login,
                                       name: name,
                                       organization: organization,
                                       userRole: selectedRole.rawValue,
                                       password: password)
        authViewModel.registerUser(with: user) { result, error in
            if let error = error {
                isShowingAlert.toggle()
                return
            } else {

            }
        }
    }
}

struct AuthViewLogin: View {
    @ObservedObject var authViewModel = AuthService()

    @State private var login: String = ""
    @State private var password: String = ""

    @State private var isShowingAlert: Bool = false

    @State private var selectedRole: UserRole = .doctor

    var body: some View {
        if !authViewModel.isLogged {
            NavigationStack {
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                VStack() {
                    TextField("Имя пользователя", text: $login)
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
                    self.loginUser()
                }) {
                    Text("Войти")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                Spacer()
                    .alert(isPresented: $isShowingAlert) {
                        Alert(title: Text("Error"), message: Text("Invalid username or password"), dismissButton: .default(Text("OK")))
                    }
            }
        } else {
            if authViewModel.authUserRole == "doctor" {
                AboutDoctorView()
            } else if authViewModel.authUserRole == "patient" {
                AboutPatientView()
            } else {
                
            }
        }
    }

    func loginUser() {
        let user = LoginUserRequest(login: "\(login)@t.ru",
                                    password: password)
        authViewModel.signIn(with: user) { error in
            if let error = error {
                isShowingAlert.toggle()
                return
            } else {
                print("OK")
                authViewModel.isLogged = true
            }
        }
    }
    func loginUserMocked() {
        let user = LoginUserRequest(login: "name@t.ru",
                                    password: "test1234")
        authViewModel.signIn(with: user) { error in
            if let error = error {
                isShowingAlert.toggle()
                return
            } else {
                print("OK")

                authViewModel.isLogged = true
            }
        }
    }
}

#Preview {
    AuthView()
}

