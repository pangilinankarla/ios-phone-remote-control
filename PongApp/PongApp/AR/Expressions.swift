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
    "neutral"
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
    "lookleft"
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
    "lookright"
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
    "lookup"
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
    "lookdown"
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
    "blink"
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
    "blink_l"
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
    "blink_r"
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

struct Angry: Expression {
  var name: String {
    "Angry"
  }
  
  var blendShapePresetName: String {
    "angry"
  }
  
  var description: String {
    "Angry"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let noseSnearLeft = from.blendShapes[.noseSneerLeft],
      let noseSnearRight = from.blendShapes[.noseSneerRight],
      let eyeSquintLeft = from.blendShapes[.eyeSquintLeft],
      let eyeSquintRight = from.blendShapes[.eyeSquintRight],
      let mouthFrownLeft = from.blendShapes[.mouthFrownLeft],
      let mouthFrownRight = from.blendShapes[.mouthFrownRight]
    else { return false }

    return noseSnearLeft.doubleValue.roundToPlaces(2) > 0.05
    && noseSnearRight.doubleValue.roundToPlaces(2) > 0.05
    && eyeSquintLeft.doubleValue.roundToPlaces(2) > 0.20
    && eyeSquintRight.doubleValue.roundToPlaces(2) > 0.20
    && mouthFrownLeft.doubleValue.roundToPlaces(2) > 0.05
    && mouthFrownRight.doubleValue.roundToPlaces(2) > 0.05
  }
}
  
  struct Joy: Expression {
    var name: String {
      "Joy"
    }
    
    var blendShapePresetName: String {
      "joy"
    }
    
    var description: String {
      "Joy"
    }
    
    func isExpressing(from: ARFaceAnchor) -> Bool {
      guard
        let mouthSmileLeft = from.blendShapes[.mouthSmileLeft],
        let mouthSmileRight = from.blendShapes[.mouthSmileRight],
        let mouthDimpleLeft = from.blendShapes[.mouthDimpleLeft],
        let mouthDimpleRight = from.blendShapes[.mouthDimpleRight]
      else { return false }

      return mouthSmileLeft.doubleValue.roundToPlaces(2) > 0.75
      && mouthSmileRight.doubleValue.roundToPlaces(2) > 0.75
      && mouthDimpleLeft.doubleValue.roundToPlaces(2) > 0.05
      && mouthDimpleRight.doubleValue.roundToPlaces(2) > 0.05
    }
}

struct Fun: Expression {
  var name: String {
    "Fun"
  }
  
  var blendShapePresetName: String {
    "fun"
  }
  
  var description: String {
    "Fun"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let mouthSmileLeft = from.blendShapes[.mouthSmileLeft],
      let mouthSmileRight = from.blendShapes[.mouthSmileRight],
      let mouthDimpleLeft = from.blendShapes[.mouthDimpleLeft],
      let mouthDimpleRight = from.blendShapes[.mouthDimpleRight],
      let mouthUpperUpLeft = from.blendShapes[.mouthUpperUpLeft],
      let mouthUpperUpRight = from.blendShapes[.mouthUpperUpRight],
      let mouthLowerDownLeft = from.blendShapes[.mouthLowerDownLeft],
      let mouthLowerDownRight = from.blendShapes[.mouthLowerDownRight],
      let eyeWideLeft = from.blendShapes[.eyeWideLeft],
      let eyeWideRight = from.blendShapes[.eyeWideRight]
    else { return false }

    return mouthSmileLeft.doubleValue.roundToPlaces(2) > 0.70
    && mouthSmileRight.doubleValue.roundToPlaces(2) > 0.70
    && mouthDimpleLeft.doubleValue.roundToPlaces(2) > 0.05
    && mouthDimpleRight.doubleValue.roundToPlaces(2) > 0.05
    && mouthUpperUpLeft.doubleValue.roundToPlaces(2) > 0.25
    && mouthUpperUpRight.doubleValue.roundToPlaces(2) > 0.25
    && mouthLowerDownLeft.doubleValue.roundToPlaces(2) > 0.5
    && mouthLowerDownRight.doubleValue.roundToPlaces(2) > 0.5
    && eyeWideLeft.doubleValue.roundToPlaces(2) > 0.2
    && eyeWideRight.doubleValue.roundToPlaces(2) > 0.2
  }
}

struct Sorrow: Expression {
  var name: String {
    "Sorrow"
  }
  
  var blendShapePresetName: String {
    "Sorrow"
  }
  
  var description: String {
    "Sorrow"
  }
  
  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let browInnerUp = from.blendShapes[.browInnerUp],
      let browOuterUpLeft = from.blendShapes[.browOuterUpLeft],
      let browOuterUpRight = from.blendShapes[.browOuterUpRight],
      let mouthLowerDownRight = from.blendShapes[.mouthLowerDownRight],
      let mouthLowerDownLeft = from.blendShapes[.mouthLowerDownLeft]
    else { return false }
    
    return browInnerUp.doubleValue.roundToPlaces(2) > 0.1
    && browOuterUpLeft.doubleValue.roundToPlaces(2) < 0.1
    && browOuterUpRight.doubleValue.roundToPlaces(2) < 0.1
    && mouthLowerDownRight.doubleValue.roundToPlaces(2) < 0.05
    && mouthLowerDownLeft.doubleValue.roundToPlaces(2) < 0.05
  }
}
