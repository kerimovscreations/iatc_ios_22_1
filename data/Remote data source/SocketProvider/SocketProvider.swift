//
//  SocketProvider.swift
//  data
//
//  Created by Karim Karimov on 23.08.22.
//

import Foundation
import RxSwift
import RxRelay
import SocketIO

class SocketProvider: SocketProviderProtocol {
    
    private let manager = SocketManager(
        socketURL: URL(string: "http://localhost:8080")!,
        config: [.log(true), .compress]
    )
    
    private lazy var socket = self.manager.defaultSocket
    
    private let messageRelay = PublishRelay<String>()
    
    init() {
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on(clientEvent: .disconnect) {data, ack in
            print("socket disconnected")
        }

        socket.on("receiveMessage") { data, ack in
            guard let msj = data[0] as? String else { return }
            print("message is received \(msj)")
            self.messageRelay.accept(msj)
        }
        
        self.socket.connect()
    }
    
    func observeMessages() -> Observable<String> {
        return self.messageRelay.asObservable()
    }
    
    func send(message: String) {
        self.socket.emit("sendMessage", ["msj": message])
    }
}
