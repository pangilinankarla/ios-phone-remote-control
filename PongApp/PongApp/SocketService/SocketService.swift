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
//        socketURL: URL(string: "ws://localhost:3000")!,
//    socketURL: URL(string: "https://192.168.0.xxx:3000")!,
//    socketURL: URL(string: "https://b74c-125-166-0-117.ap.ngrok.io")!,
//    socketURL: URL(string: "https://b873-180-191-223-253.ap.ngrok.io")!,
//    socketURL: URL(string: "ws://localhost:9000")!,
    socketURL: URL(string: "http://192.168.0.241:9000")!,
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

    socket.on("move-character") { data, ack in
      print("Move character \(data)")
//      if let data = data.first as? Data,
//         let move: Move = data.decodeToObject() {
//        DispatchQueue.main.async {
//          self?.moves.append(move)
//        }
//      }
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

  func sendBlendShapes(_ blendShapes: BlendShape) {
    guard
      let jsonData = try? JSONEncoder().encode(blendShapes),
      let jsonString = String(data: jsonData, encoding: .utf8)
    else { return }
//    print("JSON string: \(jsonString)")

    manager.defaultSocket.emit("blendShapes", jsonString)
  }
}

// AR
extension SocketService {
  func joinRoom(_ room: String) {
    let room = Room(room: "12345abc", session_id: "456xyz", name: nil)
    guard let data = try? JSONEncoder().encode(room) else { return }
    let jsonString = String(data: data, encoding: .utf8) ?? ""
    print("JSON string: \(jsonString)")

    manager.defaultSocket.emitWithAck(
      "join-room",
      with: [jsonString]
    ).timingOut(after: 0) { data in
      print("join room completion")
    }
  }

  func sendMovement(_ movement: Movement) {
    guard let data = try? JSONEncoder().encode(movement) else { return }
    let jsonString = String(data: data, encoding: .utf8) ?? ""
    print("JSON string: \(jsonString)")

    manager.defaultSocket.emitWithAck(
      "send-movement",
      with: [jsonString])
    .timingOut(after: 0) { data in
      print("sent movement!")
    }
  }
}
