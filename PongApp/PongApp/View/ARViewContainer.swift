//
//  ARViewContainer.swift
//  PongApp
//
//  Created by Quipper Indonesia on 11/08/22.
//

import SwiftUI
import ARKit
import RealityKit
import SceneKit

struct ARViewContainer: UIViewRepresentable {
  typealias UIViewType = ARSCNView
  
  func makeUIView(context: Context) -> ARSCNView {
    let arView = ARSCNView(frame: .zero)
  
    arView.setupForFaceTracking()
    
    return arView
  }
  
  func updateUIView(_ uiView: ARSCNView, context: Context) {
    
  }
  
}

extension ARSCNView: ARSessionDelegate, ARSCNViewDelegate {
  func setupForFaceTracking() {
//    guard ARFaceTrackingConfiguration.isSupported else { return }
    let configuration = ARFaceTrackingConfiguration()
    if #available(iOS 13.0, *) {
        configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
    }
    configuration.isLightEstimationEnabled = true
    self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    
    self.delegate = self
  }

  public func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    guard let sceneView = renderer as? ARSCNView,
            anchor is ARFaceAnchor else { return nil }
    let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)
    let material = faceGeometry!.firstMaterial!
    
    material.diffuse.contents = #imageLiteral(resourceName: "wireframeTexture")
    material.lightingModel = .physicallyBased
    
//    let node = SCNNode(geometry: faceMash)
//    node.geometry?.firstMaterial?.fillMode = .lines
    let node = SCNNode(geometry: faceGeometry)
    
    return node
  }
  
  public func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry{
      faceGeometry.update(from: faceAnchor.geometry)
      
      let result = readMyFace(anchor: faceAnchor)
      
      print("Your face rigth now: \(result)")
      
    }
  }
  
  func readMyFace(anchor: ARFaceAnchor) -> String {
    let mouthSmileLeft = anchor.blendShapes[.mouthSmileLeft]
    let mouthSmileRight = anchor.blendShapes[.mouthSmileRight]
    let cheekPuff = anchor.blendShapes[.cheekPuff]
    let tongueOut = anchor.blendShapes[.tongueOut]
    let jawLeft = anchor.blendShapes[.jawLeft]
    let eyeSquintLeft = anchor.blendShapes[.eyeSquintLeft]
    
    var faceResult = "You are still faced"
  
    if ((mouthSmileLeft?.decimalValue ?? 0.0) + (mouthSmileRight?.decimalValue ?? 0.0)) > 0.9 { faceResult = "You are smiling. "  }
    // smiling
    if cheekPuff?.decimalValue ?? 0.0 > 0.4 {
      faceResult = "You are puffing your cheeks "
    }
   // puffy cheeks
    if tongueOut?.decimalValue ?? 0.0 > 0.1 {faceResult = "You are sticking your tongue out"}
    // tongue out
    if jawLeft?.decimalValue ?? 0.0 > 0.1 {faceResult = "You are moving your jaw to the left"}
    // left jaw
    if eyeSquintLeft?.decimalValue ?? 0.0 > 0.2 {faceResult = "You are squinting your left eye"}
    
    return faceResult
  }

}
