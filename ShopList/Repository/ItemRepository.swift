//
//  ItemRepository.swift
//  ShopList
//
//  Created by Abraao Levi on 20/04/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import Foundation

class ItemRepository: Repository {
    
    @discardableResult
    func add(_ item: Item) -> Item? {
        let primaryKey = incrementID(for: Item.self)
        item.id = primaryKey
        
        if item.createdAt == nil {
            item.createdAt = Date()
        }
        
        return createObject(item)
    }
    
    // Adds an item to a list.
    @discardableResult
    func add(item: Item, list: List) -> Item? {
        let primaryKey = incrementID(for: Item.self)
        item.id = primaryKey
        if item.createdAt == nil {
            item.createdAt = Date()
        }
        if let createdItem = createObject(item) as Item? {
            // TODO: Research more effective way of updating an object
            let newList = List()
            newList.id = list.id
            newList.name = list.name
            for i in list.items {
                newList.items.append(i)
            }
            newList.items.append(createdItem)
            _ = updateObject(newList)
            return createdItem
        }
        return nil
    }

    @discardableResult
    func delete(_ item: Item) -> Bool {
        return deleteObject(item)
    }

    func link(_ item: Item, to list: List) {
        list.items.append(item)
    }
}
