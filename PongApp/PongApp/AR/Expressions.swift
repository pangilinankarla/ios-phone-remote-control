//
//  Expressions.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import ARKit

// MARK: - Neutral
struct NeutralExpression: Expression {
  var name: String {
    "Neutral"
  }

  var blendShapePresetName: String {
    name
  }

  var description: String {
    name.lowercased()
  }

  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let mouthClose = from.blendShapes[.mouthClose],
      let jawOpen = from.blendShapes[.jawOpen]
    else { return false }

    return mouthClose.doubleValue.roundToPlaces(2) < 0.1
     && jawOpen.doubleValue.roundToPlaces(2) < 0.3
  }

  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool {
    guard
      let eyeSquintLeft = from.blendShapes[.eyeSquintLeft],
      let eyeSquintRight = from.blendShapes[.eyeSquintRight],
      let eyeWideLeft = from.blendShapes[.eyeWideLeft],
      let eyeWideRight = from.blendShapes[.eyeWideRight]
    else { return false }
    
    return eyeSquintLeft.doubleValue.roundToPlaces(1) > 0.7
      && eyeSquintRight.doubleValue.roundToPlaces(1) > 0.7
      && eyeWideLeft.doubleValue.roundToPlaces(1) > 0.7
      && eyeWideRight.doubleValue.roundToPlaces(1) > 0.7
  }
}

// MARK: - LookLeft
struct LookLeftExpression: Expression {
  var name: String {
    "LookLeft"
  }

  var blendShapePresetName: String {
    "Lookleft"
  }
  
  var description: String {
    "looking to the left"
  }

  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let eyeLookInLeft = from.blendShapes[.eyeLookInLeft],
      let eyeLookOutRight = from.blendShapes[.eyeLookOutRight]
    else { return false }
    
    return eyeLookInLeft.doubleValue.roundToPlaces(1) > 0.4
      && eyeLookOutRight.doubleValue.roundToPlaces(1) > 0.4
  }
}

// MARK: - LookRight
struct LookRightExpression: Expression {
  var name: String {
    "LookRight"
  }
  
  var blendShapePresetName: String {
    "Lookright"
  }
  
  var description: String {
    "looking to the right"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let eyeLookInRight = from.blendShapes[.eyeLookInRight],
      let eyeLookOutLeft = from.blendShapes[.eyeLookOutLeft]
    else { return false }
    
    return eyeLookInRight.doubleValue.roundToPlaces(1) > 0.4
      && eyeLookOutLeft.doubleValue.roundToPlaces(1) > 0.4
  }
}

// MARK: - LookUp
struct LookUpExpression: Expression {
  var name: String {
    "LookUp"
  }
  
  var blendShapePresetName: String {
    "Lookup"
  }
  
  var description: String {
    "looking up"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let eyeLookUpLeft = from.blendShapes[.eyeLookUpLeft],
      let eyeLookUpRight = from.blendShapes[.eyeLookUpRight]
    else { return false }
    
    return eyeLookUpLeft.doubleValue.roundToPlaces(1) > 0.4
      && eyeLookUpRight.doubleValue.roundToPlaces(1) > 0.4
  }
}

// MARK: - LookDown
struct LookDownExpression: Expression {
  var name: String {
    "LookDown"
  }
  
  var blendShapePresetName: String {
    "Lookdown"
  }
  
  var description: String {
    "looking down"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let eyeLookDownLeft = from.blendShapes[.eyeLookDownLeft],
      let eyeLookDownRight = from.blendShapes[.eyeLookDownRight]
    else { return false }
    
    return eyeLookDownLeft.doubleValue.roundToPlaces(1) > 0.1
      && eyeLookDownRight.doubleValue.roundToPlaces(1) > 0.1
  }

  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool {
    guard
      let eyeBlinkLeft = from.blendShapes[.eyeBlinkLeft],
      let eyeBlinkRight = from.blendShapes[.eyeBlinkRight]
    else { return false }
    
    return eyeBlinkLeft.doubleValue.roundToPlaces(1) > 0.8
      && eyeBlinkRight.doubleValue.roundToPlaces(1) > 0.8
  }
}

// MARK: - Blink
struct BlinkExpression: Expression {
  var name: String {
    "Blink"
  }
  
  var blendShapePresetName: String {
    "Blink"
  }
  
  var description: String {
    "blinked"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let eyeBlinkLeft = from.blendShapes[.eyeBlinkLeft],
      let eyeBlinkRight = from.blendShapes[.eyeBlinkRight]
    else { return false }
    
    return eyeBlinkLeft.doubleValue.roundToPlaces(1) > 0.8
      && eyeBlinkRight.doubleValue.roundToPlaces(1) > 0.8
  }
}

// MARK: - BlinkLeft
struct BlinkLeftExpression: Expression {
  var name: String {
    "BlinkLeft"
  }
  
  var blendShapePresetName: String {
    "BlinkL"
  }
  
  var description: String {
    "blinked left"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard let eyeBlinkLeft = from.blendShapes[.eyeBlinkLeft] else { return false }
    
    return eyeBlinkLeft.doubleValue.roundToPlaces(1) > 0.8
  }

  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool {
    guard let eyeBlinkRight = from.blendShapes[.eyeBlinkRight] else { return false }
    
    return eyeBlinkRight.doubleValue.roundToPlaces(1) > 0.4
  }
}

// MARK: - BlinkRight
struct BlinkRightExpression: Expression {
  var name: String {
    "BlinkRight"
  }
  
  var blendShapePresetName: String {
    "BlinkR"
  }
  
  var description: String {
    "blinked right"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard let eyeBlinkRight = from.blendShapes[.eyeBlinkRight] else { return false }
    
    return eyeBlinkRight.doubleValue.roundToPlaces(1) > 0.8
  }
  
  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool {
    guard let eyeBlinkLeft = from.blendShapes[.eyeBlinkLeft] else { return false }
    
    return eyeBlinkLeft.doubleValue.roundToPlaces(1) > 0.4
  }
}
