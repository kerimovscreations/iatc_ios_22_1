//
//  SocketProviderProtocol.swift
//  data
//
//  Created by Karim Karimov on 23.08.22.
//

import Foundation
import RxSwift

protocol SocketProviderProtocol {
    func observeMessages() -> Observable<String>
    func send(message: String)
}
