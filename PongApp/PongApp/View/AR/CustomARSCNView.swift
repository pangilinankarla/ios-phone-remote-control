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
    LetterAExpression(),
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
      expressions = result.1
      // TODO: ❗️ Call socket – send `expression` && Send Unknown if empty ❗️
      print("New expressions: \(expressions)\n")
      
      let newBlendShape = BlendShape.generateFromExpressions(expressions)
      
      if newBlendShape != currentBlendShape {
        currentBlendShape = newBlendShape
        service?.sendBlendShapes(newBlendShape)
      }
    }
  }

  func readMyFace(anchor: ARFaceAnchor) -> (String, [Expression]) {
    let mouthSmileLeft = anchor.blendShapes[.mouthSmileLeft]? .doubleValue ?? 0.0
    let mouthSmileRight = anchor.blendShapes[.mouthSmileRight]?.doubleValue ?? 0.0
    let cheekPuff = anchor.blendShapes[.cheekPuff]?.doubleValue ?? 0.0
    let tongueOut = anchor.blendShapes[.tongueOut]?.doubleValue ?? 0.0
    let jawLeft = anchor.blendShapes[.jawLeft]?.doubleValue ?? 0.0
    let jawOpen = anchor.blendShapes[.jawOpen]?.doubleValue ?? 0.0
    let eyeSquintLeft = anchor.blendShapes[.eyeSquintLeft]?.doubleValue ?? 0.0
    let eyeSquintRight = anchor.blendShapes[.eyeSquintRight]?.doubleValue ?? 0.0
    let eyeWideLeft = anchor.blendShapes[.eyeWideLeft]?.doubleValue ?? 0.0
    let eyeWideRight = anchor.blendShapes[.eyeWideRight]?.doubleValue ?? 0.0
    let eyeBlinkLeft = anchor.blendShapes[.eyeBlinkLeft]?.doubleValue ?? 0.0
    let eyeBlinkRight = anchor.blendShapes[.eyeBlinkRight]?.doubleValue ?? 0.0

//    let facialExpression = FacialExpression(
//      mouthSmileLeft: mouthSmileLeft.roundToPlaces(1),
//      mouthSmileRight: mouthSmileRight.roundToPlaces(1),
//      cheekPuff: cheekPuff.roundToPlaces(1),
//      tongueOut: tongueOut.roundToPlaces(1),
//      jawOpen: jawOpen.roundToPlaces(1),
//      eyeSquintLeft: eyeSquintLeft.roundToPlaces(1),
//      eyeSquintRight: eyeSquintRight.roundToPlaces(1),
//      eyeWideLeft: eyeWideLeft.roundToPlaces(1),
//      eyeWideRight: eyeWideRight.roundToPlaces(1),
//      eyeBlinkLeft: eyeBlinkLeft.roundToPlaces(1),
//      eyeBlinkRight: eyeBlinkRight.roundToPlaces(1)
//    )

    let defaultString = "(No expression)"
    var faceResultArray: [String] = []
    
    // Smiling
    if (mouthSmileLeft + mouthSmileRight) > 0.9 {
      faceResultArray.append("smiling")
    }
    
    // Puffy cheeks
    if cheekPuff > 0.4 {
      faceResultArray.append("puffing your cheeks")
    }
    
    // Tongue out
    if tongueOut > 0.1 {
      faceResultArray.append("sticking your tongue out")
    }
    
    // Jaw left
    if jawLeft > 0.1 {
      faceResultArray.append("moving your jaw to the left")
    }

    // Squint left
    if eyeSquintLeft > 0.2 {
      faceResultArray.append("squinting your left eye")
    }

    // Squint right
    if eyeSquintRight > 0.2 {
      faceResultArray.append("squinting your right eye")
    }

    let result = !faceResultArray.isEmpty ? "You are \(faceResultArray.joined(separator: ", "))" : defaultString

    let expressionArr: [Expression] = validExpressions.filter { $0.isExpressing(from: anchor) && !$0.isDoingWrongExpression(from: anchor) }

    return (result, expressionArr)
  }
}
