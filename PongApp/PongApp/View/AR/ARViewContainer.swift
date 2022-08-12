//
//  ARViewContainer.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI

// MARK: - Logger Protocol
protocol ARSCNViewLogger {
  func log(_ log: String)
}

// MARK: - ARViewContainer
struct ARViewContainer: UIViewRepresentable {
  typealias UIViewType = CustomARSCNView
  @ObservedObject var service: SocketService
  @Binding var message: String

  func makeUIView(context: Context) -> CustomARSCNView {
    let arView = CustomARSCNView(frame: .zero)
    arView.logger = self
    arView.service = service
    arView.setupForFaceTracking()
    
    return arView
  }
  
  func updateUIView(_ uiView: CustomARSCNView, context: Context) {
    
  }
}

extension ARViewContainer: ARSCNViewLogger {
  func log(_ log: String) {
    message = log
  }
}
