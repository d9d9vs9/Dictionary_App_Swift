//
//  MDCreateCourseCoreDataStorageOperation.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 24.08.2021.
//

import CoreData

final class MDCreateCourseCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let coreDataStorage: MDCourseCoreDataStorage
    fileprivate let courseEntity: CourseResponse
    fileprivate let result: MDOperationResultWithCompletion<CourseResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         coreDataStorage: MDCourseCoreDataStorage,
         courseEntity: CourseResponse,
         result: MDOperationResultWithCompletion<CourseResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.courseEntity = courseEntity
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        let newCourseEntity = CDCourseResponseEntity.init(courseResponse: self.courseEntity,
                                                          insertIntoManagedObjectContext: self.managedObjectContext)
        
        coreDataStack.save(managedObjectContext: managedObjectContext) { [weak self] result in
            
            switch result {
            
            case .success:
                self?.result?(.success((newCourseEntity.courseResponse)))
                self?.finish()
                break
                
            case .failure(let error):
                self?.result?(.failure(error))
                self?.finish()
                break
            }
            
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}

final class MDCreateCoursesCoreDataStorageOperation: MDAsyncOperation {
    
    fileprivate let managedObjectContext: NSManagedObjectContext
    fileprivate let coreDataStack: MDCoreDataStack
    fileprivate let coreDataStorage: MDCourseCoreDataStorage
    fileprivate let courseEntities: [CourseResponse]
    fileprivate let result: MDOperationsResultWithCompletion<CourseResponse>?
    
    init(managedObjectContext: NSManagedObjectContext,
         coreDataStack: MDCoreDataStack,
         coreDataStorage: MDCourseCoreDataStorage,
         courseEntities: [CourseResponse],
         result: MDOperationsResultWithCompletion<CourseResponse>?) {
        
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
        self.coreDataStorage = coreDataStorage
        self.courseEntities = courseEntities
        self.result = result
        
        super.init()
    }
    
    override func main() {
        
        if (self.courseEntities.isEmpty) {
            self.result?(.success(self.courseEntities))
            self.finish()
        } else {
            
            var resultCount: Int = .zero
            
            self.courseEntities.forEach { courseEntity in
                
                let _ = CDCourseResponseEntity.init(courseResponse: courseEntity,
                                                    insertIntoManagedObjectContext: self.managedObjectContext)
                
                
                coreDataStack.save(managedObjectContext: managedObjectContext) { [weak self] result in
                    
                    switch result {
                    
                    case .success:
                        
                        resultCount += 1
                        
                        if (resultCount == self?.courseEntities.count) {
                            self?.result?(.success(self?.courseEntities ?? []))
                            self?.finish()
                            break
                        }
                        
                    case .failure(let error):
                        self?.result?(.failure(error))
                        self?.finish()
                        break
                    }
                    
                }
                
            }
            
        }
        
    }
    
    deinit {
        debugPrint(#function, Self.self)
        self.finish()
    }
    
}
