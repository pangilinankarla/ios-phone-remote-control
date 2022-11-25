//
//  PongAppApp.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

@main
struct PongAppApp: App {
  private var service: SocketService! = nil

  init() {
    service = SocketService()
    service.establishConnection()
  }

    var body: some Scene {
        WindowGroup {
          NavigationView {
            ContentView().environmentObject(service)
          }
        }
    }
}
