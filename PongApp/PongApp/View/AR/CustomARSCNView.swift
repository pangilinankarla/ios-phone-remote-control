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
    Neutral(),
    LookLeft(),
    LookRight(),
    LookUp(),
    LookDown(),
    Blink(),
    BlinkLeft(),
    BlinkRight(),
    Angry(),
    Joy(),
    Fun(),
    Sorrow(),
    LetterA(),
//    LetterE(),
//    LetterI(),
//    LetterO(),
//    LetterU(),
  ]
  var logger: ARSCNViewLogger?
  var service: SocketService?
  private var expressions = [Expression]()
  private var expressionString = ""
  private var currentBlendShape: BlendShape?
}

// MARK: - Public methods
extension CustomARSCNView {
  func setupForFaceTracking() {
    let configuration = ARFaceTrackingConfiguration()
    if #available(iOS 13.0, *) {
      configuration.maximumNumberOfTrackedFaces = ARFaceTrackingConfiguration.supportedNumberOfTrackedFaces
    }
    configuration.isLightEstimationEnabled = true
    self.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    
    self.delegate = self
  }
}

// MARK: - ARSCNViewDelegate
extension CustomARSCNView: ARSCNViewDelegate {
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    guard
      let sceneView = renderer as? ARSCNView,
      anchor is ARFaceAnchor
    else { return nil }

    let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)
    let material = faceGeometry!.firstMaterial!

    material.diffuse.contents = #imageLiteral(resourceName: "wireframeTexture")
    material.lightingModel = .physicallyBased

    let node = SCNNode(geometry: faceGeometry)

    return node
  }

  func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
    guard
      let faceAnchor = anchor as? ARFaceAnchor,
      let faceGeometry = node.geometry as? ARSCNFaceGeometry
    else { return }

    faceGeometry.update(from: faceAnchor.geometry)

    let newBlendShape = readMyFace(anchor: faceAnchor)

    if newBlendShape != currentBlendShape {
      currentBlendShape = newBlendShape
      sendMovement(newBlendShape)
    }

  }
}

import Accelerate

// MARK: - Private methods
extension CustomARSCNView {
  private func readMyFace(anchor: ARFaceAnchor) -> BlendShape {
    let blendShape = BlendShape(
      a: validExpressions.first(where: { $0 is LetterA })?.getValue(from: anchor) ?? 0.0,
      angry: validExpressions.first(where: { $0 is Angry })?.getValue(from: anchor) ?? 0.0,
      blink: validExpressions.first(where: { $0 is Blink })?.getValue(from: anchor) ?? 0.0,
      blinkLeft: validExpressions.first(where: { $0 is BlinkLeft })?.getValue(from: anchor) ?? 0.0,
      blinkRight: validExpressions.first(where: { $0 is BlinkRight })?.getValue(from: anchor) ?? 0.0,
      e: validExpressions.first(where: { $0 is LetterE })?.getValue(from: anchor) ?? 0.0,
      fun: validExpressions.first(where: { $0 is Fun })?.getValue(from: anchor) ?? 0.0,
      i: validExpressions.first(where: { $0 is LetterI })?.getValue(from: anchor) ?? 0.0,
      joy: validExpressions.first(where: { $0 is Joy })?.getValue(from: anchor) ?? 0.0,
      lookDown: validExpressions.first(where: { $0 is LookDown })?.getValue(from: anchor) ?? 0.0,
      lookLeft: validExpressions.first(where: { $0 is LookLeft })?.getValue(from: anchor) ?? 0.0,
      lookRight: validExpressions.first(where: { $0 is LookRight })?.getValue(from: anchor) ?? 0.0,
      lookUp: validExpressions.first(where: { $0 is LookUp })?.getValue(from: anchor) ?? 0.0,
      neutral: validExpressions.first(where: { $0 is Neutral })?.getValue(from: anchor) ?? 0.0,
      o: validExpressions.first(where: { $0 is LetterO })?.getValue(from: anchor) ?? 0.0,
      sorrow: validExpressions.first(where: { $0 is Sorrow })?.getValue(from: anchor) ?? 0.0,
      u: validExpressions.first(where: { $0 is LetterU })?.getValue(from: anchor) ?? 0.0,
      unknown: 0
    )

    return blendShape
  }

  private func sendMovement(_ blendShape: BlendShape?) {
    guard let blendShape else { return }

    print("\nSEND BLENDSHAPE: \(blendShape)\n\n")

    service?.sendBlendShape(blendShape)
  }

  private func testSendMovement() {
    let bShape = BlendShape(
      a: 0,
      angry: 0,
      blink: 0,
      blinkLeft: 0,
      blinkRight: 0,
      e: 0,
      fun: 0,
      i: 0,
      joy: 0,
      lookDown: 0,
      lookLeft: 0,
      lookRight: 0,
      lookUp: 0,
      neutral: 0,
      o: 0,
      sorrow: 0,
      u: 0,
      unknown: 0
    )

    print("*** TEST BLEND SHAPE: \(bShape)\n")

    sendMovement(bShape)
  }
}

extension ARFaceAnchor {
  func blendShapeDoubleValue(_ blendShape: ARFaceAnchor.BlendShapeLocation, max: Double? = nil) -> Double {
    let doubleValue = blendShapes[blendShape]?.doubleValue.roundToPlaces(4) ?? 0.0

    if let max, doubleValue > max {
      return max
    } else {
      return doubleValue
    }
  }
}

extension Double {
  func withThreshold(_ threshold: Double) -> Double {
    return (self > threshold) ? threshold : self
  }
}
