//
//  MovementView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct MovementView: View {
  @EnvironmentObject var service: SocketService

  var body: some View {
    NavigationView {
      Form {
        NavigationLink {
          PongRemoteView().environmentObject(service)
        } label: {
          Text("Pong Remote")
        }
        
        NavigationLink {
          ARFaceView().environmentObject(service)
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
