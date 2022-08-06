//
//  UserRepoTests.swift
//  dataTests
//
//  Created by Karim Karimov on 06.08.22.
//

import Foundation
import XCTest
import RxRelay
import RxSwift
import Promises
@testable import data
import domain

class UserRepoTests: XCTestCase {
    
    var userRepo: UserRepoProtocol!
    var userLocalDataSource: UserLocalDataSourceMockData!
    var userRemoteDataSource: UserRemoteDataSourceMockData!
    
    var compositeDisposable: CompositeDisposable!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        compositeDisposable = CompositeDisposable()
        
        userLocalDataSource = UserLocalDataSourceMockData()
        userRemoteDataSource = UserRemoteDataSourceMockData()
        
        userRepo = UserRepo(
            remoteDataSource: userRemoteDataSource,
            localDataSource: userLocalDataSource)
    }
    
    override func tearDownWithError() throws {
        compositeDisposable.dispose()
        
        try super.tearDownWithError()
    }
    
    func testSyncUser() {
        let remoteUser = UserRemoteDTO(name: "name", email: "email", phoneNumber: "232424")
        
        self.userRemoteDataSource.fetchUserPromise = Promise<UserRemoteDTO>.pending()
        
        let expectedLocalDto = remoteUser.toLocal()
        
        var savedInLocal = false
        let subscription = self.userLocalDataSource.observeSaveCall()
            .subscribe { received in
                guard let data = received.element else { return }
                
                XCTAssertFalse(savedInLocal)
                XCTAssertEqual(data, expectedLocalDto)
                savedInLocal = true
            }
        
        let _ = self.compositeDisposable.insert(subscription)
        
        self.userLocalDataSource.savePromise = Promise<Void>.pending()
        
        let expectation = XCTestExpectation()
        
        self.userRepo.syncUser()
            .then { _ in
                expectation.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        self.userRemoteDataSource.fetchUserPromise.fulfill(
            remoteUser
        )
        
        self.userLocalDataSource.savePromise.fulfill(())
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertTrue(savedInLocal)
    }
}
