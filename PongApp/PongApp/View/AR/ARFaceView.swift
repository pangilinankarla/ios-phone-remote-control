//
//  ARFaceView.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

struct ARFaceView: View {
  @ObservedObject var service: SocketService

  init(service: SocketService) {
    self.service = service
    service.establishConnection()
  }

  @State private var log = ""
    var body: some View {
      VStack {
        ARViewContainer(service: service, message: $log)
          .edgesIgnoringSafeArea(.all)
        
        Text("\(log)")
      }
        
    }
}

struct ARFaceView_Previews: PreviewProvider {
    static var previews: some View {
      ARFaceView(service: SocketService())
    }
}
