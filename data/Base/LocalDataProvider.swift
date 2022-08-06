//
//  LocalDataProvider.swift
//  dataTests
//
//  Created by Karim Karimov on 06.08.22.
//

import Foundation
import RealmSwift
import Promises

protocol LocalDataProviderProtocol {
    func save<Element: Object>(items: [Element]) -> Promise<Void>
}

class LocalDataProvider: LocalDataProviderProtocol {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func save<Element: Object>(items: [Element]) -> Promise<Void> {
        let promise = Promise<Void>.pending()
        
        do {
            try realm.write({
                realm.add(items)
            })
            promise.fulfill(())
        } catch {
            promise.reject(error)
        }
        return promise
    }
}
