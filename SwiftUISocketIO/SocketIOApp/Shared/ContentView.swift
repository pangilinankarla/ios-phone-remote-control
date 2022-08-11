//
//  ContentView.swift
//  Shared
//
//  Created by Karla Pangilinan on 8/11/22.
//

import SwiftUI
import SocketIO

struct ContentView: View {
  @StateObject private var service = SocketService()

  var body: some View {
    VStack(spacing: 20) {
      Text("Received messages from Node.js:")
        .font(.title)
        .padding(.horizontal)
      
      Button("Connect") {
        service.establishConnection()
      }
      
      Button("Disconnect") {
        service.closeConnection()
      }
      
      Button("Move") {
        service.sendMove()
      }

      if !service.message.isEmpty {
        Text("Message received: \"\(service.message)\"")
      }
      
      Text("Moves sent: \(service.moves.count)")
      Form {
        ForEach(service.moves) { move in
          Text("\(move.id ?? "")")
        }
      }
      Spacer()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
