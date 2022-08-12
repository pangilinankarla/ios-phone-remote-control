//
//  CustomARSCNView.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import ARKit
import RealityKit
import SceneKit

final class CustomARSCNView: ARSCNView {
  private let validExpressions: [Expression] = [
    NeutralExpression(),
    LookLeftExpression(),
    LookRightExpression(),
    LookUpExpression(),
    LookDownExpression(),
    BlinkExpression(),
    BlinkLeftExpression(),
    BlinkRightExpression(),
    Angry(),
    Joy(),
    Fun(),
    Sorrow(),
    LetterAExpression(),
    LetterIExpression(),
    LetterUExpression(),
    LetterEExpression(),
    LetterOExpression(),
  ]
  var logger: ARSCNViewLogger?
  var service: SocketService?
  private var expressions = [Expression]()
  private var expressionString = ""
  private var currentBlendShape: BlendShape?
}

extension CustomARSCNView: ARSessionDelegate, ARSCNViewDelegate {
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
  
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    guard
      let sceneView = renderer as? ARSCNView,
      anchor is ARFaceAnchor
    else { return nil }

    let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)
    let material = faceGeometry!.firstMaterial!
    
    material.diffuse.contents = #imageLiteral(resourceName: "wireframeTexture")
    material.lightingModel = .physicallyBased
    
    //    let node = SCNNode(geometry: faceMash)
    //    node.geometry?.firstMaterial?.fillMode = .lines
    let node = SCNNode(geometry: faceGeometry)
    
    return node
  }
  
  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    guard
      let faceAnchor = anchor as? ARFaceAnchor,
      let faceGeometry = node.geometry as? ARSCNFaceGeometry
    else { return }
    
    faceGeometry.update(from: faceAnchor.geometry)
    let result = readMyFace(anchor: faceAnchor)

    if expressionString != result.0 {
      expressionString = result.0
      print(expressionString)
      logger?.log(expressionString)
    }

    if !(expressions == result.1) {
      expressions.removeAll()
      result.1.forEach { expressions.append($0.copy() as! Expression) }
      print("New expressions: \(expressions)\n")
      
      let newBlendShape = BlendShape.generateFromExpressions(expressions)
      
      if newBlendShape != currentBlendShape {
        currentBlendShape = newBlendShape
        service?.sendBlendShapes(newBlendShape)
      }
    }
  }

  func readMyFace(anchor: ARFaceAnchor) -> (String, [Expression]) {
    let defaultString = "(No expression)"
    var faceResultArray: [String] = []
    
    let result = !faceResultArray.isEmpty ? "You are \(faceResultArray.joined(separator: ", "))" : defaultString

    let expressionArr: [Expression] = validExpressions.filter { $0.isExpressing(from: anchor) && !$0.isDoingWrongExpression(from: anchor) }

    return (result, expressionArr)
  }
}
