//
//  MDWordManager.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 10.11.2021.
//

import Foundation

protocol MDWordManagerProtocol: MDCreateWordProtocol,
                                MDUpdateWordTextAndWordDescriptionProtocol {
    
}

final class MDWordManager: MDWordManagerProtocol {
    
    fileprivate let wordCoreDataStorage: MDWordCoreDataStorageProtocol
    
    init(wordCoreDataStorage: MDWordCoreDataStorageProtocol) {
        self.wordCoreDataStorage = wordCoreDataStorage
    }
    
    deinit {
        debugPrint(#function, Self.self)
    }
    
}

// MARK: - Create
extension MDWordManager {
    
    func createWord(courseUUID: UUID,
                    uuid: UUID,
                    wordText: String,
                    wordDescription: String,
                    createdAt: Date,
                    _ completionHandler: @escaping (MDOperationResultWithCompletion<CDWordEntity>)) {
        
        wordCoreDataStorage.exists(byCourseUUID: courseUUID,
                                   andWordText: wordText) { [unowned self] existsResult in
            
            switch existsResult {
                
            case .success(let exists):
                
                if (exists) {
                    
                    //
                    completionHandler(.failure(MDWordOperationError.wordExists))
                    //
                    
                    //
                    return
                    //
                    
                } else {
                    
                    wordCoreDataStorage.createWord(courseUUID: courseUUID,
                                                   uuid: uuid,
                                                   wordText: wordText,
                                                   wordDescription: wordDescription,
                                                   createdAt: createdAt) { createResult in
                        
                        //
                        completionHandler(createResult)
                        //
                        
                        //
                        return
                        //
                        
                    }
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                //
                completionHandler(.failure(error))
                //
                
                //
                break
                //
                
            }
            
        }
        
    }
    
}

// MARK: - Update
extension MDWordManager {
    
    func updateWordTextAndWordDescription(byCourseUUID courseUUID: UUID,
                                          andWordUUID wordUUID: UUID,
                                          newWordText: String,
                                          newWordDescription: String,
                                          _ completionHandler: @escaping (MDOperationResultWithCompletion<Void>)) {
        
        wordCoreDataStorage.exists(byCourseUUID: courseUUID, andWordText: newWordText) { [unowned self] existsResult in
            
            switch existsResult {
                
            case .success(let exists):
                
                if (exists) {
                    
                    wordCoreDataStorage.readWord(byCourseUUID: courseUUID,
                                                 andWordText: newWordText) { [unowned self] readResult in
                        
                        switch readResult {
                            
                        case .success(let readEntity):
                            
                            //
                            if (readEntity.uuid! == wordUUID) {
                                
                                wordCoreDataStorage.updateWordDescription(byCourseUUID: courseUUID,
                                                                          andWordUUID: wordUUID,
                                                                          newWordDescription: newWordDescription) { updateResult in
                                    
                                    //
                                    completionHandler(updateResult)
                                    //
                                    
                                    //
                                    return
                                    //
                                    
                                }
                                
                            } else {
                                
                                //
                                completionHandler(.failure(MDWordOperationError.wordExists))
                                //
                                
                                //
                                break
                                //
                                
                            }
                            //
                            
                            //
                            break
                            //
                            
                        case .failure(let error):
                            
                            //
                            completionHandler(.failure(error))
                            //
                            
                            //
                            break
                            //
                            
                        }
                        
                    }
                    
                } else {
                    
                    wordCoreDataStorage.updateWordTextAndWordDescription(byCourseUUID: courseUUID,
                                                                         andWordUUID: wordUUID,
                                                                         newWordText: newWordText,
                                                                         newWordDescription: newWordDescription) { updateResult in
                        
                        //
                        completionHandler(updateResult)
                        //
                        
                        //
                        return
                        //
                        
                    }
                    
                }
                
                //
                break
                //
                
            case .failure(let error):
                
                //
                completionHandler(.failure(error))
                //
                
                //
                break
                //
                
            }
            
        }
        
    }
    
}
