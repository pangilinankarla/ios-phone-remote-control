//
//  Expression.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import ARKit

protocol Expression {
  var name: String { get }
  var blendShapePresetName: String { get }
  var description: String { get }

  // should return true when the ARFaceAnchor is performing the expression we want
  func isExpressing(from: ARFaceAnchor) -> Bool

  // should return true when the ARFaceAnchor is performing the WRONG expression from what we want.
  // For example, if the expression is "Blink Left",
  // then this should return true if the user's right eyelid is also closed.
  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal
}

extension Expression {
  func isExpressing(from: ARFaceAnchor) -> Bool {
    return false
  }

  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool {
    return false
  }
}
