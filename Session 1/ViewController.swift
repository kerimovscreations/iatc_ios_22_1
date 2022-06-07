//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit
import Alamofire
import Promises
import RxSwift
import RxRelay

class ViewController: UIViewController {
    
    let crtBase64 = "MIIFFzCCA/+gAwIBAgISBA1MJx6IatcwFed2q9Fqf/ZiMA0GCSqGSIb3DQEBCwUAMDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQDEwJSMzAeFw0yMjA1MjIxOTUxMDhaFw0yMjA4MjAxOTUxMDdaMBQxEjAQBgNVBAMTCXN3YXBpLmRldjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANrl/w0yNiqhFI1qLGAnnhBVxsQ3w3/KGjVGZsBAG/OrerXVg0kcZgqUkq8YNlPhzRTD47Rd2nfR7AjVwNKjQQFSIJSOHnj1SWEBeuI/H5lnL0mIKVbLex95JKHQrAxwj6MFB2jsFalvLoDtwdWLYf7R/OSbY8vqNu1cCw1Hif8I51QAmWavVVs/1wZWc/BRrphHgXUkAX/YzXx1g5G5x7J2xbz6kLf+fXJoH3rf/+PIlZL7JnirHnpqaAYFBrMBUXvGXruuWo5+xUAvjbnYXrN/803G60/uYUDR1rjkm0XOyqQvyO8GJBbys4Y7UyIHUzentUuVzY1oWq5XYF8WSZECAwEAAaOCAkMwggI/MA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwDAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQU02s3miYklAUNPlM3x/dFByYutiswHwYDVR0jBBgwFoAUFC6zF7dYVsuuUAlA5h+vnYsUwsYwVQYIKwYBBQUHAQEESTBHMCEGCCsGAQUFBzABhhVodHRwOi8vcjMuby5sZW5jci5vcmcwIgYIKwYBBQUHMAKGFmh0dHA6Ly9yMy5pLmxlbmNyLm9yZy8wFAYDVR0RBA0wC4IJc3dhcGkuZGV2MEwGA1UdIARFMEMwCAYGZ4EMAQIBMDcGCysGAQQBgt8TAQEBMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly9jcHMubGV0c2VuY3J5cHQub3JnMIIBAwYKKwYBBAHWeQIEAgSB9ASB8QDvAHYA36Veq2iCTx9sre64X04+WurNohKkal6OOxLAIERcKnMAAAGA7Ym79QAABAMARzBFAiBBucwT8b7fSsv18QnBASkJAdt4gafUdl/j2ta58cTKRQIhAJxhuN0zcYXPWTapI/ZlSPCHnImxoF4fAOouaounScfmAHUARqVV63X6kSAwtaKJafTzfREsQXS+/Um4havy/HD+bUcAAAGA7Ym8FwAABAMARjBEAiBresVy0ovmK75neP7OaU9yTBiVvPn1uHXexpacwZLzCQIgEs0SFVAmGVWpmIWHwhBBbNC4V9DSBRUhicIxNk0J4CUwDQYJKoZIhvcNAQELBQADggEBAKTUyJsJgiG7/8xLFg72m5N0gx4wZq8j/blf2n46D0pqBng/BRcNpiDvbf1khCyQ0+KX6YY0kLGyl39S0rtMm0opFjSykUvYHxbz4Gba4yqfizBb4HAgxR0DmvIKovVfaRRwNV+cSPcQk42Sm7dgPBrOZYDbYmP2yJZU5QzM614lYGDWrmisaQKKns/URl+hnWLpvR26oym4FKerJS3eDI1Wj/XXvybDCrXCFiLHJ/MMlUmz/vjxfwtvK6rNWq6vuDMqfHnhoJqJKOwWmCeuXpCXAG6V2p44vUdvntNbUBJv8GTTWevXZ8CoM2GCggcEEe27ixOQgmGTubAd4GO2FnY="
    
    lazy var session: Session = {
        var evaluators: [String: ServerTrustEvaluating] = [:]
        
        
        if let certificateData = Data(base64Encoded: crtBase64, options: []),
            let certificate = SecCertificateCreateWithData(nil, certificateData as CFData) {
            //  use certificate to initialize PinnedCertificatesTrustEvaluator, or ...
            
            let serverTrustEvaluating: ServerTrustEvaluating = .pinnedCertificates(
                certificates: [certificate],
                acceptSelfSignedCertificates: false,
                performDefaultValidation: true,
                validateHost: true)
            
            evaluators["swapi.dev"] = serverTrustEvaluating
        }
        
        let interceptor = Interceptor(
            adapters: [],
            retriers: [],
            interceptors: [])
        
        let session = Session(
            interceptor: interceptor,

            serverTrustManager: ServerTrustManager.init(
                evaluators: evaluators
            )
        )
        return session
    }()
    
    var disposeBag: DisposeBag? = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        fetchUser()
            .then { user -> Promise<[Computer]> in
                print(user)
                return self.fetchComputers()
            }
            .then { computers -> Promise<String> in
                print(computers)

                return Promise<String> {
                    return "Success"
                }
            }
            .then{ message in
                print(message)
            }
            .catch { error in
                print(error)
            }
        
//        all(fetchUser(), fetchComputers())
//            .always {
//                print("completed all")
//            }
//            .then({ user, computer in
//                print("print all")
//                print(user)
//                print(computer)
//            })
//            .catch({ error in
//                print(error)
//            })
                    
//        any(fetchUser(), fetchComputers())
//            .always {
//                print("completed any")
//            }
//            .then({ user, computers in
//                print("print any")
//
//                switch user {
//                case .value(let safeUser):
//                    print("safe user \(safeUser)")
//                case .error(let userError):
//                    print("error user \(userError)")
//                }
//
//                if let safeUser = user.value {
//                    print("safe user \(safeUser)")
//                }
//
//                if let safeComputers = computers.value {
//                    print("safe computers \(safeComputers)")
//                }
//            })
//            .catch({ error in
//                print("catch any")
//                print(error)
//            })
        
//        fetchComputers().recover { error -> Promise<[Computer]> in
//            print("Fetch computers error \(error)")
//            return Promise<[Computer]>{ return [Computer.init(name: "Unknown")] }
//        }
//        .then { computers -> Promise<User> in
//            print(computers)
//            return self.fetchUser()
//        }
//        .then { user in
//            print(user)
//        }.catch { error in
//            print("general error \(error)")
//        }
    
//        fetchUserCallbackPromise()
//            .then { user in
//                print(user)
//            }
//            .catch { error in
//                print(error)
//            }
        
        
//        let fibonacciSequence = Observable.from([0,1,1,2,3,5,8])
//
//        let subscription = fibonacciSequence.subscribe { value in
//            print(value)
//        } onError: { error in
//            print(error)
//        } onCompleted: {
//            print("on completed")
//        } onDisposed: {
//            print("on disposed")
//        }
//
//        subscription.disposed(by: disposeBag!)
        
//        let asyncSubj = AsyncSubject<Int>.init()
//
//        let subscriptionAsync = asyncSubj.subscribe { received in
//            guard let value = received.element else { return }
//
//            print(value)
//        }
//
//        subscriptionAsync.disposed(by: disposeBag!)
//
//        asyncSubj.onNext(1)
//        asyncSubj.onNext(2)
//        asyncSubj.onNext(3)
//        asyncSubj.onCompleted()
        
        
        let behaviorSubj = ReplayRelay<Int>.create(bufferSize: 5)
        
        let subscriptionBehav = behaviorSubj.subscribe { received in
            guard let value = received.element else { return }
            
            print("subscribe 1: \(value)")
        }
        
        subscriptionBehav.disposed(by: disposeBag!)
        
        
        behaviorSubj.accept(1)
        behaviorSubj.accept(2)
        behaviorSubj.accept(3)
        
        let subscriptionBehav2 = behaviorSubj.subscribe { received in
            guard let value = received.element else { return }
            
            print("subscribe 2: \(value)")
        }
        
        subscriptionBehav2.disposed(by: disposeBag!)
        
        behaviorSubj.accept(4)
        behaviorSubj.accept(5)
        
        let subscriptionBehav3 = behaviorSubj.subscribe { received in
            guard let value = received.element else { return }
            
            print("subscribe 3: \(value)")
        }
        
        subscriptionBehav3.disposed(by: disposeBag!)
        
        behaviorSubj.accept(6)
    }
    
        func fetchUser() -> Promise<User> {
            let promise = Promise<User>.pending()
    
            let request = self.session.request("https://swapi.dev/api/starships")
    
            request
                .validate()
                .responseDecodable(of: User.self) { response in
                    if let err = response.error {
                        promise.reject(err)
                        return
                    }
    
                    guard let user = response.value else {
                        promise.reject(DataError(message: "Parsing error"))
                        return
                    }
    
                    promise.fulfill(user)
                }
    
            return promise
        }
    
//    func fetchUser() -> Promise<User> {
//        let promise = Promise<User>(on: .main) { fulfill, reject in
//            let request = self.session.request("http://0.0.0.0:3000/user")
//
//            request
//                .validate()
//                .responseDecodable(of: User.self) { response in
//                    if let err = response.error {
//                        reject(err)
//                        return
//                    }
//
//                    guard let user = response.value else {
//                        reject(DataError(message: "Parsing error"))
//                        return
//                    }
//
//                    fulfill(user)
//                }
//        }
//
//        return promise
//    }
//
//    func fetchUserCallback(onResult: @escaping (User) -> Void){
//        let request = self.session.request("http://0.0.0.0:3000/user")
//
//        request
//            .validate()
//            .responseDecodable(of: User.self) { response in
//                if let _ = response.error {
//                    return
//                }
//
//                guard let user = response.value else {
//                    return
//                }
//
//                onResult(user)
//            }
//    }
    
//    func fetchUserCallbackPromise() -> Promise<User> {
//        return wrap { handler in
//            self.fetchUserCallback(onResult: handler)
//        }
//    }
//
    func fetchComputers() -> Promise<[Computer]> {
        let promise = Promise<[Computer]>.pending()

        let request = self.session.request("http://0.0.0.0:3000/computers")

        request
            .validate()
            .responseDecodable(of: [Computer].self) { response in
                if let err = response.error {
                    promise.reject(err)
                    return
                }

                guard let computers = response.value else {
                    promise.reject(DataError(message: "Parsing error"))
                    return
                }

                promise.fulfill(computers)
            }

        return promise
    }
}

struct User: Decodable {
    let email: String
    let name: String
}

struct Computer: Decodable {
    let name: String
}

struct DataError: Error {
    let message: String
}
