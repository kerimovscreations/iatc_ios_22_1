//
//  ViewModel.swift
//  Session 1
//
//  Created by Karim Karimov on 18.06.22.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

class ViewModel {
    
    private let stateRelay = BehaviorRelay<State?>.init(value: nil)
    private let effectRelay = PublishRelay<Effect>.init()
    
    private lazy var defaultErrorHandler: (Error) -> Void = { err in
        self.effectRelay.accept(.error(error: err))
    }
    
    func fetchUserData() {
        Task(priority: .medium) {
//            let chicken = Chicken()
//
//            print(chicken.food)
//            print(await chicken.weight)
//            await chicken.feed()
//            print(await chicken.weight)
//            await chicken.fasting()
//            print(await chicken.weight)
//            chicken.printFood()
            
            let chicken = ChickenClass()
            
            print(chicken.food)
            print(chicken.weight)
            chicken.feed()
            print(chicken.weight)
            chicken.fasting()
            print(chicken.weight)
            
            let task1 = Task(priority: .userInitiated) { () -> [[User]] in
                
                async let users: [User] = self.request(url: "http://0.0.0.0:3000/users", method: .get)
                async let users2: [User] = self.request(url: "http://0.0.0.0:3000/users", method: .get)
                async let users3: [User] = self.request(url: "http://0.0.0.0:3000/users", method: .get)
                
                print("called")
                
                return try await [users, users2, users3]
            }
            
            print("cancelled")
            task1.cancel()
            
            do {
                print("Is cancelled: \(task1.isCancelled)")
                print("Task result: \(await task1.result)")
                
                let result: [User] = try await task1.value.flatMap { users in
                    users
                }
                self.stateRelay.accept(.show(user: result))
            } catch {
                self.effectRelay.accept(.error(error: error))
            }
        }
    }
    
    func observeState() -> Observable<State> {
        return stateRelay
            .filter({ state in
                state != nil
            })
            .map({ state in
                state!
            })
            .asObservable()
    }
    
    func observeEffect() -> Observable<Effect> {
        return effectRelay.asObservable()
    }
    
    func request<O>(
        url: String,
        method: HTTPMethod
    ) async throws -> O where O : Decodable {
        
        try await withUnsafeThrowingContinuation { continuation in
            
            AF.request(url, method: method)
            .validate()
            .responseDecodable(of: O.self) { response in
                if let err = response.error {
                    continuation.resume(with: .failure(err))
                    return
                }
                
                guard let data = response.value else {
                    continuation.resume(with: .failure(DataError(message: "ParsingError")))
                    return
                }
                
                continuation.resume(with: .success(data))
            }
        }
    }
    
}

struct DataError: Error {
    let message: String
}

enum State {
    case show(user: [User])
}

enum Effect {
    case error(error: Error)
}

struct User: Decodable, Sendable {
    let name: String
}

class Location: @unchecked Sendable {
    let lat: Double = 0.0
    let long: Double = 0.0
}

class CustomLocation: Location {
    let name: String = ""
}

actor Chicken {
    let food = "worm"
    var weight: Double = 0.0
    
    func feed() {
        weight += 1.0
    }
    
    func fasting() {
        weight -= 1.0
    }
    
    nonisolated func printFood() {
        print("Eating only \(food)")
    }
}

final class ChickenClass {
    let food = "wheat"
    var weight: Double = 0.0
    
    let queue = DispatchQueue(label: "chicken.eat.queue", attributes: .concurrent)
    
    func feed() {
        // blocks reads while writing
        queue.sync(flags: .barrier) {
            weight += 1.0
        }
    }
    
    func fasting() {
        // blocks reads while writing
        queue.sync(flags: .barrier) {
            weight -= 1.0
        }
    }
}
