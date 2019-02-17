//
//  ListRepository.swift
//  ShopList
//
//  Created by Abraao Levi on 17/02/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import Foundation

class ListRepository: Repository {
    
    func add(_ list: List) {
        createObject(list)
    }
    
    func delete(_ list: List) {
        deleteObject(list)
    }
    
    func findAllLists() -> [List] {
        return findAll(type: List.self)?.toArray(type: List.self) ?? []
    }
    
}