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
