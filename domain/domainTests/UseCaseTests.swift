//
//  UseCaseTests.swift
//  domainTests
//
//  Created by Karim Karimov on 06.08.22.
//

import XCTest
import Promises
import RxSwift
@testable import domain

class UseCaseTests: XCTestCase {
    
    var userRepo: UserRepoMockData!
    
    var compositeDisposable: CompositeDisposable!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        userRepo = UserRepoMockData()
        compositeDisposable = CompositeDisposable()
    }
    
    override func tearDownWithError() throws {
        
        compositeDisposable.dispose()
        
        try super.tearDownWithError()
    }
    
    func testGetUserUseCaseSuccess() {
        let useCase = GetUserUseCase(repo: self.userRepo)
        
        let expectation = XCTestExpectation(description: "Get user should return a value")
        
        let expectedUser = UserEntity(
            name: "name", email: "email", phone: "phone")
        
        self.userRepo.getUserPromise = Promise<UserEntity>.pending()
        self.userRepo.getUserPromise.fulfill(
            expectedUser
        )
        
        var returnedUser: UserEntity? = nil
        
        useCase.execute()
            .then { user in
                // check
                returnedUser = user
                expectation.fulfill()
            }
            .catch { error in
                XCTFail("Get user failed")
            }
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertNotNil(returnedUser)
        XCTAssertEqual(returnedUser, expectedUser)
    }
    
    func testGetUserUseCaseError() {
        let useCase = GetUserUseCase(repo: self.userRepo)
        
        let expectation = XCTestExpectation(description: "Get user should return a value")
        
        self.userRepo.getUserPromise = Promise<UserEntity>.pending()
        self.userRepo.getUserPromise.reject(ParsingError())
        
        useCase.execute()
            .then { user in
                // check
                XCTFail("Get user failed")
            }
            .catch { error in
                XCTAssertTrue(error is ParsingError)
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testObserveUserUseCase() {
        let useCase = ObserveUserUseCase(repo: self.userRepo)
        
        let expectedUser = UserEntity(
            name: "name", email: "email", phone: "phone")
        
        let expectedUser2 = UserEntity(
            name: "name2", email: "email", phone: "phone")
        
        let expectedUser3 = UserEntity(
            name: "name3", email: "email", phone: "phone")
        
        let expectation = XCTestExpectation(description: "User entity should be observed")
        
        var returnedUsers = [UserEntity]()
        let expectedUsers = [expectedUser, expectedUser2, expectedUser3]
        
        let subscription = useCase.execute()
            .subscribe { received in
                guard let data = received.element else {
                    XCTFail("User is nil")
                    return
                }
                
                returnedUsers.append(data)
                expectation.fulfill()
            }
        
        let _ = self.compositeDisposable.insert(subscription)
        
        self.userRepo.observeUserValue.accept(expectedUser)
        self.userRepo.observeUserValue.accept(expectedUser2)
        self.userRepo.observeUserValue.accept(expectedUser3)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(returnedUsers, expectedUsers)
    }
    
    func testSyncUserUseCaseSucces() {
        let useCase = SyncUserUseCase(repo: self.userRepo)
        
        self.userRepo.syncUserPromise = Promise<Void>.pending()
        
        let expectation = XCTestExpectation()
        
        useCase.execute()
            .then { _ in
                expectation.fulfill()
            }
            .catch { _ in
                XCTFail()
            }
        
        self.userRepo.syncUserPromise.fulfill(())
        
        wait(for: [expectation], timeout: 1.0)
    }
}
