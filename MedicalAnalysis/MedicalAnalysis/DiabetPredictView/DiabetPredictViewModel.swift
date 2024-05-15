//
//  DiabetPredictViewModel.swift
//  MedicalAnalysis
//
//  Created by Матвей Матюшко on 15.05.2024.
//
//
//import Foundation
//
//class DiabetPredictViewModel {
//    private let healthDataService = DiabetPedictService()
//    private var wordsUIModel = [WordUIModel]()
//
//        @Published var stepData: [Step] = []
//        @Published var stepApiData: [StepApiModel] = []
//
//    
//
//    func loadMedCard() async throws -> MedCardApiModel {
//        let wordsAPIModel = try await learningViewService.loadWords()
//        var wordsUIModel: [WordUIModel] = []
//        for word in wordsAPIModel {
//            let wordUIModel = WordUIModel(categoryId: word.categoryId,
//                                          translations: word.translations,
//                                          isLearned: word.isLearned,
//                                          swipesCounter: word.swipesCounter,
//                                          id: word.id)
//            wordsUIModel.append(wordUIModel)
//        }
//        return wordsUIModel
//    }
//
//    func loadCategory(with categoryId: String) async throws -> [WordUIModel] {
//        let wordsAPIModel = try await learningViewService.loadWordsInCategory(with: categoryId)
//        var wordsUIModel: [WordUIModel] = []
//
//        for word in wordsAPIModel {
//            let wordUIModel = WordUIModel(categoryId: word.categoryId,
//                                          translations: word.translations,
//                                          isLearned: word.isLearned,
//                                          swipesCounter: word.swipesCounter,
//                                          id: word.id)
//            wordsUIModel.append(wordUIModel)
//        }
//
//        return wordsUIModel
//    }
//
//    func postWords(words: [WordUIModel]) async throws {
//        for word in words {
//            try await learningViewService.createNewTopFiveWord(with: word)
//        }
//    }
//
//    func updateWords(words: [WordUIModel]) async throws {
//        for word in words {
//            try await learningViewService.updateWord(with: word)
//        }
//    }
//    func updateWord(words: WordUIModel) async throws {
//            try await learningViewService.updateWord(with: words)
//    }
//}
