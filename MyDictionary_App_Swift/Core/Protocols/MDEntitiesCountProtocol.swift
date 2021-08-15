//
//  MDEntitiesCountProtocol.swift
//  MyDictionary_App_Swift
//
//  Created by Dmytro Chumakov on 13.07.2021.
//

import Foundation

protocol MDEntitiesCountProtocol {
    func entitiesCount(_ completionHandler: @escaping (MDEntityCountResult))
}
