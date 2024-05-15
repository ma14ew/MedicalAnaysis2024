//
//  AuthService.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 26.04.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

final class AuthService: ObservableObject {

    private enum CreateUserFields {
        static let login = "login"
        static let name = "name"
        static let organization = "organization"
        static let userRole = "userRole"
        static let password = "password"
        static let userId = "userId"
    }

    private enum TableNames {
        static let users = "users"
        static let userId = "userId"
        static let userRole = "userRole"
    }
    public static let shared = AuthService()

    private let dataBase = Firestore.firestore()

    @Published var authUserRole = ""
    @Published var isLogged: Bool = false

    @Published var requestModel = RegisterUserRequest(login: "",
                                                      name: "",
                                                      organization: "",
                                                      userRole: "",
                                                      password: "")

    public func registerUser(with userRequest: RegisterUserRequest,
                             completion: @escaping (Bool, Error?) -> Void) {
        let login = userRequest.login
        let name = userRequest.name
        let organization = userRequest.organization
        let userRole = userRequest.userRole
        let password = userRequest.password

        Auth.auth().createUser(withEmail: login,
                               password: password) { result, error in
            if let error = error {
                completion(false, error)
                print(error)
                return
            }
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }

            let database = Firestore.firestore()
            database.collection("users")
                .document(resultUser.uid)
                .setData([
                    CreateUserFields.login: login,
                    CreateUserFields.name: name,
                    CreateUserFields.organization: organization,
                    CreateUserFields.userRole: userRole,
                    CreateUserFields.userId: resultUser.uid
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }

    public func signIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: userRequest.login,
                           password: userRequest.password) { _, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }

    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }


    public func checkUserRole(with userId: String) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            dataBase.collection(TableNames.users)
                .whereField(TableNames.userId, isEqualTo: userId).getDocuments { querySnapshot, error in
                    if let error = error {
                        print(error)
                        continuation.resume(throwing: error)
                        return
                    }
                    guard let documents = querySnapshot?.documents else {
                        continuation.resume(throwing: NetworkError.unexpected)
                        return
                    }
                    let users: [UserApiModel] = documents.compactMap { document in
                        do {
                            let user = try document.data(as: UserApiModel.self)
                            return user
                        } catch {
                            continuation.resume(throwing: error)
                            return nil
                        }
                    }
                    continuation.resume(returning: users[0].userRole)
                }
        }
    }

    public func checkAuthentication() -> String? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        } else {
            return nil
        }
    }
}

struct RegisterUserRequest: Decodable {
    let login: String
    let name: String
    let organization: String
    let userRole: String
    let password: String
}

struct LoginUserRequest {
    let login: String
    let password: String
}


enum NetworkError: Error {
    case unexpected
    case unexpectedURL
    case emptyData
}


struct UserApiModel: Decodable {
    let login: String
    let name: String
    let organization: String
    let userRole: String
    let userId: String
}
