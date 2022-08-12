//
//  LetterExpressions.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import ARKit

// MARK: - A
class LetterAExpression: Expression {
  var value: Double = 0.0
  
  var name: String {
    "A"
  }

  var blendShapePresetName: String {
    "a"
  }
  
  var description: String {
    "saying `A`"
  }

  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard let jawOpen = from.blendShapes[.jawOpen] else { return false }
    
    return jawOpen.doubleValue.roundToPlaces(1) > 0.3
  }

  func copy(with zone: NSZone? = nil) -> Any {
    let copy = LetterAExpression()
    copy.value = value
    return copy
  }
}

class LetterIExpression: Expression {
  var value: Double = 0.0
  
  var name: String {
    "I"
  }

  var blendShapePresetName: String {
    "i"
  }
  
  var description: String {
    "saying `I`"
  }

  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let jawOpen = from.blendShapes[.jawOpen],
      let mouthSmileRight = from.blendShapes[.mouthSmileRight],
      let mouthSmileLeft = from.blendShapes[.mouthSmileLeft]
    else { return false }
    
    return jawOpen.doubleValue.roundToPlaces(1) < 0.3
    && mouthSmileRight.doubleValue.roundToPlaces(2) > 0.3
    && mouthSmileLeft.doubleValue.roundToPlaces(2) > 0.3
  }

  func copy(with zone: NSZone? = nil) -> Any {
    let copy = LetterIExpression()
    copy.value = value
    return copy
  }
}

class LetterUExpression: Expression {
  var value: Double = 0.0
  
  var name: String {
    "U"
  }

  var blendShapePresetName: String {
    "u"
  }
  
  var description: String {
    "saying `U`"
  }

  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let jawOpen = from.blendShapes[.jawOpen],
      let mouthRight = from.blendShapes[.mouthRight],
      let mouthLeft = from.blendShapes[.mouthLeft]
    else { return false }
    
    return jawOpen.doubleValue.roundToPlaces(1) < 0.3
    && mouthRight.doubleValue.roundToPlaces(2) < 0.3
    && mouthLeft.doubleValue.roundToPlaces(2) < 0.3
  }

  func copy(with zone: NSZone? = nil) -> Any {
    let copy = LetterUExpression()
    copy.value = value
    return copy
  }
}

class LetterEExpression: Expression {
  var value: Double = 0.0

  var name: String {
    "E"
  }

  var blendShapePresetName: String {
    "e"
  }
  
  var description: String {
    "saying `E`"
  }

  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let jawOpen = from.blendShapes[.jawOpen],
      let mouthSmileLeft = from.blendShapes[.mouthSmileLeft],
      let mouthSmileRight = from.blendShapes[.mouthSmileRight]
    else { return false }
      
    return jawOpen.doubleValue.roundToPlaces(1) > 0.2
    && mouthSmileLeft.doubleValue.roundToPlaces(1) < 0.5
    && mouthSmileRight.doubleValue.roundToPlaces(1) < 0.5
  }

  func copy(with zone: NSZone? = nil) -> Any {
    let copy = LetterEExpression()
    copy.value = value
    return copy
  }
}

class LetterOExpression: Expression {
  var value: Double = 0.0

  var name: String {
    "O"
  }

  var blendShapePresetName: String {
    "o"
  }
  
  var description: String {
    "saying `O`"
  }

  func isExpressing(from: ARFaceAnchor) -> Bool {
    guard
      let jawOpen = from.blendShapes[.jawOpen],
      let mouthLowerDownLeft = from.blendShapes[.mouthLowerDownLeft],
      let mouthLowerDownRight = from.blendShapes[.mouthLowerDownRight]
    else { return false }
  
    return jawOpen.doubleValue.roundToPlaces(1) > 0.2
    && mouthLowerDownLeft.doubleValue.roundToPlaces(1) < 0.3
    && mouthLowerDownRight.doubleValue.roundToPlaces(1) < 0.3
  }

  func copy(with zone: NSZone? = nil) -> Any {
    let copy = LetterOExpression()
    copy.value = value
    return copy
  }
}
