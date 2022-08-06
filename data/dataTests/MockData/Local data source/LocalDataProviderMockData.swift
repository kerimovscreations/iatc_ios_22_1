//
//  LocalDataProviderMockData.swift
//  dataTests
//
//  Created by Karim Karimov on 06.08.22.
//

import Foundation
import RealmSwift
import RxSwift
import RxRelay
import Promises
@testable import data

class LocalDataProviderMockData: LocalDataProviderProtocol {
    var savePromise = Promise<Void>.pending()
    
    private let saveCall = PublishRelay<[Object]>()
    
    func save<Element: Object>(items: [Element]) -> Promise<Void> {
        saveCall.accept(items)
        return savePromise
    }
}
