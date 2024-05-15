//
//  DiabetPedictService.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 15.05.2024.
//

import Foundation
import HealthKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth


class DiabetPedictService {

    private enum TableNames {
        static let users = "users"
        static let userId = "userId"
        static let userRole = "userRole"
        static let medCards = "medCards"
        static let stepData = "stepData"
    }

    private let dataBase = Firestore.firestore()

//    func loadWords() async throws -> MedCardApiModel {
////        let categories = try await loadCategories()
////        var words = [WordApiModel]()
//        for category in categories {
//            let categoryId = category.linkedWordsId
//            do {
//                let categoryWords = try await loadWordsInCategory(with: categoryId)
//                words.append(contentsOf: categoryWords)
//            } catch {
//                throw error
//            }
//        }
//        return words
//    }


    public func createNewMedicalCard(with card: MedCardApiModel) async throws {
        guard let userId = checkAuthentication() else {
            throw AuthErrors.userNotAuthenticated
        }
            let uploadMedCard = try await makeMedCardForRequest(with: card)
            try await addDocumentMedCardFireBase(dict: uploadMedCard)
    }

    public func createNewStepData(with steps: StepApiModel) async throws {
        guard let userId = checkAuthentication() else {
            throw AuthErrors.userNotAuthenticated
        }
            let uploadStepData = try await makeStepDataForRequest(with: steps)
            try await addDocumentStepDataFireBase(dict: uploadStepData)
    }

//    public func updateData(with word: WordUIModel) async throws {
//        guard let userId = checkAuthentication() else {
//            throw AuthErrors.userNotAuthenticated
//        }
//        try await updateWord(id: word.id,
//                             isLearned: word.isLearned,
//                             swipesCounter: word.swipesCounter)
//    }

    private func addDocumentMedCardFireBase(dict: [String: Any]) async throws {
        do {
            try await dataBase.collection(TableNames.medCards).addDocument(data: dict)
        } catch {
            throw error
        }
    }

    private func makeMedCardForRequest(with card: MedCardApiModel) async throws -> [String: Any] {
        guard let userId = checkAuthentication() else {
            throw AuthErrors.userNotAuthenticated
        }
        let newCard: [String: Any] = [
            "userId": userId,
            "name": card.name,
            "gender": card.gender,
            "hypertension": card.hypertension,
            "heart_disease": card.heart_disease,
            "bmi": card.bmi,
            "hb": card.hb,
            "blood": card.blood,
        ]
        return newCard
    }

    private func addDocumentStepDataFireBase(dict: [String: Any]) async throws {
        do {
            try await dataBase.collection(TableNames.stepData).addDocument(data: dict)
        } catch {
            throw error
        }
    }

    private func makeStepDataForRequest(with card: StepApiModel) async throws -> [String: Any] {
        guard let userId = checkAuthentication() else {
            throw AuthErrors.userNotAuthenticated
        }
        let newCard: [String: Any] = [
            "userId": userId,
            "stepsInDay": card.stepsInDay
        ]
        return newCard
    }

//    private func updateWord(id: String, isLearned: Bool, swipesCounter: Int) async throws {
//        try await dataBase.collection(TableNames.medCards).document(id).setData(["isLearned": isLearned,
//                                                                     "swipesCounter": swipesCounter], merge: true)
//    }

    private func checkAuthentication() -> String? {
        if let currentUser = Auth.auth().currentUser {
            return currentUser.uid
        } else {
            return nil
        }
    }

}

enum AuthErrors: Error {
    case userNotAuthenticated
}

