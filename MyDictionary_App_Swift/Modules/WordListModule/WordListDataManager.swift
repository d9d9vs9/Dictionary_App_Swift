//
//  WordListDataManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 16.05.2021.
//

import Foundation

protocol WordListDataManagerInputProtocol {
    func readAndAddWordsToDataProvider()
    func filterWords(_ searchText: String?)
    func clearWordFilter()
}

protocol WordListDataManagerOutputProtocol: AnyObject {
    func readAndAddWordsToDataProviderResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func filteredWordsResult(_ result: MDOperationResultWithoutCompletion<Void>)
    func clearWordFilterResult(_ result: MDOperationResultWithoutCompletion<Void>)
}

protocol WordListDataManagerProtocol: WordListDataManagerInputProtocol {
    var dataProvider: WordListDataProviderProcotol { get }
    var dataManagerOutput: WordListDataManagerOutputProtocol? { get set }
}

final class WordListDataManager: WordListDataManagerProtocol {
    
    fileprivate let memoryStorage: MDWordMemoryStorageProtocol
    var dataProvider: WordListDataProviderProcotol
    
    internal weak var dataManagerOutput: WordListDataManagerOutputProtocol?
    
    init(dataProvider: WordListDataProviderProcotol,
         memoryStorage: MDWordMemoryStorageProtocol) {
        
        self.dataProvider = dataProvider
        self.memoryStorage = memoryStorage
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - WordListDataManagerInputProtocol
extension WordListDataManager {
    
    func readAndAddWordsToDataProvider() {
        
        memoryStorage.readAllWords(byCourseID: dataProvider.course.courseId) { [unowned self] result in
            
            switch result {
                
            case .success(let words):
                // Set Words
                dataProvider.filteredWords = words
                // Pass Result
                dataManagerOutput?.readAndAddWordsToDataProviderResult(.success(()))
                //
                break
                //
            case .failure(let error):
                // Pass Result
                dataManagerOutput?.readAndAddWordsToDataProviderResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
    func filterWords(_ searchText: String?) {
        
        memoryStorage.readAllWords(byCourseID: dataProvider.course.courseId) { [weak self] readResult in
            
            switch readResult {
                
            case .success(let readWords):
                // Set Filtered Result
                self?.dataProvider.filteredWords = self?.filteredWords(input: readWords,
                                                                       searchText: searchText) ?? []
                // Pass Result
                self?.dataManagerOutput?.filteredWordsResult(.success(()))
                //
                break
                //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.filteredWordsResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
    func clearWordFilter() {
        
        memoryStorage.readAllWords(byCourseID: dataProvider.course.courseId) { [weak self] readResult in
            
            switch readResult {
                
            case .success(let readWords):
                // Set Read Results
                self?.dataProvider.filteredWords = readWords
                // Pass Result
                self?.dataManagerOutput?.clearWordFilterResult(.success(()))
                //
                break
                //
            case .failure(let error):
                // Pass Result
                self?.dataManagerOutput?.clearWordFilterResult(.failure(error))
                //
                break
                //
            }
            
        }
        
    }
    
}

// MARK: - Private Methods
fileprivate extension WordListDataManager {
    
    func filteredWords(input words: [WordResponse],
                       searchText: String?) -> [WordResponse] {
        if (MDConstants.Text.textIsEmpty(searchText)) {
            return words
        } else {
            return words.filter({ $0.wordText.lowercased().contains(searchText!.lowercased()) })
        }
    }
    
}
