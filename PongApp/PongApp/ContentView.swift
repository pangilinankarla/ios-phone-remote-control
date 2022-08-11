//
//  ContentView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct ContentView: View {
  @State var isLoggedIn: Bool = false
  var body: some View {
    if !isLoggedIn {
      Login(isLoggedIn: $isLoggedIn)
    } else {
      MovementView()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
