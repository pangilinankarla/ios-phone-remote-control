//
//  LetterExpressions.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import ARKit

// MARK: - A
struct LetterAExpression: Expression {
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
}

struct LetterIExpression: Expression {
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
}

struct LetterUExpression: Expression {
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
}
