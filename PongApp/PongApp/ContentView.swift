//
//  ContentView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject var service: SocketService
  @State var isLoggedIn: Bool = false

  var body: some View {
    if !isLoggedIn {
//      Login(isLoggedIn: $isLoggedIn)
      LoginView().environmentObject(service)
    } else {
      MovementView().environmentObject(service)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
