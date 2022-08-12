//
//  MovementView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct MovementView: View {
  @StateObject private var service = SocketService()
  
  var body: some View {
    NavigationView {
      Form {
        NavigationLink {
          PongRemoteView(service: service)
        } label: {
          Text("Pong Remote")
        }
        
        NavigationLink {
          ARFaceView(service: service)
        } label: {
          Text("AR Camera")
        }
      }
    }
  }
}

struct MovementView_Previews: PreviewProvider {
    static var previews: some View {
        MovementView()
    }
}
