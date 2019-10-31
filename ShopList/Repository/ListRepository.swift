//
//  ListRepository.swift
//  ShopList
//
//  Created by Abraao Levi on 17/02/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import Foundation

class ListRepository: Repository {

    @discardableResult
    func add(_ list: List) -> List? {
        let primaryKey = incrementID(for: List.self)
        list.id = primaryKey
        
        if list.createdAt == nil {
            list.createdAt = Date()
        }
        
        if list.modifiedAt == nil {
            list.modifiedAt = Date()
        }
        
        return createObject(list)
    }

    @discardableResult
    func delete(_ list: List) -> Bool {
        return deleteObject(list)
    }
    
    @discardableResult
    func filterAllLists(withName name: String) -> [List] {
        // example usage without using NSPredicate
        return findAll(type: List.self)?.filter("name = '\(name)'").toArray(type: List.self) ?? []
    }
    
    @discardableResult
    func filterAllLists(withPredicate predicate: NSPredicate) -> [List] {
        return filterAll(type: List.self, predicate: predicate)?.toArray(type: List.self) ?? []
    }

    func findAllLists() -> [List] {
        guard let result = findAll(type: List.self) else {
            return []
        }
        
        return result
            .sorted(byKeyPath: "modifiedAt", ascending: false)
            .toArray(type: List.self)
    }
    
}
