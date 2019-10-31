//
//  Repository.swift
//  ShopList
//
//  Created by Abraao Levi on 17/02/19.
//  Copyright © 2019 Abraao Levi. All rights reserved.
//

import Foundation
import RealmSwift

class Repository {
    
    let realm: Realm
    
    init() {
        realm = PersisterManager.shared.realm
    }
    
    func createObject<T: Object>(_ obejct: T) -> T? {
        do {
            try realm.write {
                realm.add(obejct)
            }
            return obejct
        } catch {
            printLog(error.localizedDescription)
        }
        return nil
    }
    
    func updateObject<T: Object>(_ object: T) -> T? {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
            return object
        } catch {
            printLog(error.localizedDescription)
        }
        return nil
    }

    func deleteObject(_ obejct: Object) -> Bool {
        do {
            try realm.write {
                realm.delete(obejct)
            }
            return true
        } catch {
            printLog(error.localizedDescription)
        }
        return false
    }

    func findAll<T: Object>(type: T.Type) -> Results<T>? {
        return realm.objects(type)
    }

    func filterAll<T: Object>(type: T.Type, predicate: NSPredicate) -> Results<T>? {
        return realm.objects(type).filter(predicate)
    }
    
    func incrementID<T: Object>(for type: T.Type) -> Int {
        let lastId = realm.objects(type).max(ofProperty: "id") as Int? ?? 0
        return lastId + 1
    }
}
