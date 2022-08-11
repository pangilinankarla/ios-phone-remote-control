//
//  SocketService.swift
//  SocketIOApp
//
//  Created by Karla Pangilinan on 8/11/22.
//

import Foundation
import SocketIO

final class SocketService: ObservableObject {
  // TODO: ❗️ Replace url string to test ❗️
  private var manager = SocketManager(
    //    socketURL: URL(string: "ws://localhost:3000")!,
//    socketURL: URL(string: "http://192.168.0.xxx:3000")!,
    socketURL: URL(string: "https://b74c-125-166-0-117.ap.ngrok.io")!,
    config: [.log(true), .compress]
  )
  
  @Published var moves: [Move] = .init()
  @Published var message: String = ""
  
  init() {
    let socket = manager.defaultSocket
    socket.on(clientEvent: .connect) { data, ack in
      print("Connected")
      socket.emit("NodeJS Server Port", "Hi, NodeJS server!")
    }
    
    socket.on("iOS Client Port") { [weak self] data, ack in
      if let data = data.first as? [String: String],
         let message = data["msg"] {
        DispatchQueue.main.async {
          self?.message = message
        }
      }
    }
    
    socket.on("Move received") { [weak self] data, ack in
      print("Move received \(data)")
      if let data = data.first as? Data,
         let move: Move = data.decodeToObject() {
        DispatchQueue.main.async {
          self?.moves.append(move)
        }
      }
    }
  }
  
  func establishConnection() {
    manager.defaultSocket.connect()
  }
  
  func closeConnection() {
    manager.defaultSocket.disconnect()
  }
  
  func sendMove(_ move: Move) {
//    guard let jsonData = try? JSONEncoder().encode(move) else { return }
    manager.defaultSocket.emit("move", "playerOneUp")
  }

  func sendMoveDown(_ move: Move) {
//    guard let jsonData = try? JSONEncoder().encode(move) else { return }
    manager.defaultSocket.emit("move", "playerOneDown")
  }
}
