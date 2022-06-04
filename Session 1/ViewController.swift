//
//  ViewController.swift
//  Session 1
//
//  Created by Karim Karimov on 05.04.22.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController {
    
    private var accessToken = "token1"
    private var refreshToken = "11111"
    
    lazy var session: Session = {
        let authAdapter = AuthAdapter.init {
            return self.accessToken
        }
        
        let authRetrier = AuthRetrier.init {
            return self.refreshToken
        } onUpdateAccessToken: { tokenData in
            self.accessToken = tokenData.accessToken
            self.refreshToken = tokenData.refreshToken
        }

        
        let interceptor = Interceptor(
            adapters: [authAdapter],
            retriers: [authRetrier],
            interceptors: [])
        
        let session = Session(interceptor: interceptor)
        return session
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        fetchUsers()
    }
    
    func fetchUsers() {
//        let request = AF.request("http://0.0.0.0:3001/users", headers: ["Authorization": "token1"])
//
//        request.responseJSON { data in
//            print(data)
//        }
        
        let request = self.session.request("http://0.0.0.0:3001/users")
        
        request
            .validate()
            .responseJSON { data in
            print(data)
        }
        
//        request.responseDecodable(of: [User].self) { response in
//            print(response.value)
//        }
    }
}

class AuthAdapter: Alamofire.RequestAdapter {
    
    var getToken: () -> String
    
    init(getToken: @escaping () -> String) {
        self.getToken = getToken
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        urlRequest.setValue(getToken(), forHTTPHeaderField: "Authorization")
        
        completion(.success(urlRequest))
    }
}

class AuthRetrier: Alamofire.RequestRetrier {
    
    var getRefreshToken: () -> String
    var onUpdateAccessToken: (AuthToken) -> Void
    
    init(getRefreshToken: @escaping () -> String,
         onUpdateAccessToken: @escaping (AuthToken) -> Void) {
        self.getRefreshToken = getRefreshToken
        self.onUpdateAccessToken = onUpdateAccessToken
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        print("error catched")
        
        if request.response?.statusCode == 401 {
            print("cathed 401")
            
            let request = AF.request(
                "http://0.0.0.0:3001/refresh-token",
                headers: ["Refresh-token": getRefreshToken()])
            request.responseDecodable(of: AuthToken.self) { response in
                if let data = response.value {
                    self.onUpdateAccessToken(data)
                    completion(.retry)
                } else {
                    completion(.doNotRetry)
                }
            }
        } else {
            completion(.doNotRetry)
        }
    }
    
}

struct AuthToken: Decodable {
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token",
             refreshToken = "refresh_token"
    }
}

struct User: Decodable {
    let id: String
}
