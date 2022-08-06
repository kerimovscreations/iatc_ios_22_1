//
//  UserLocalDataSourceTests.swift
//  dataTests
//
//  Created by Karim Karimov on 06.08.22.
//

import Foundation
import XCTest
@testable import data

class UserLocalDataSourceTests: XCTestCase {
    
    var userLocalDataSource: UserLocalDataSourceProtocol!
    var localDataProvider: LocalDataProviderMockData!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.localDataProvider = LocalDataProviderMockData()
        self.userLocalDataSource = UserLocalDataSource(
            localDataProvider: self.localDataProvider)
    }
}
