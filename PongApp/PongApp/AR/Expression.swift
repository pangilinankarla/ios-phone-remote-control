//
//  Expression.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import ARKit

protocol Expression: IsEqual, NSCopying {
  var name: String { get }
  var blendShapePresetName: String { get }
  var description: String { get }
  var value: Double { get set }
  
  // should return true when the ARFaceAnchor is performing the expression we want
  func isExpressing(from: ARFaceAnchor) -> Bool

  // should return true when the ARFaceAnchor is performing the WRONG expression from what we want.
  // For example, if the expression is "Blink Left",
  // then this should return true if the user's right eyelid is also closed.
  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool
}

extension Expression {
  func isExpressing(from: ARFaceAnchor) -> Bool {
    return false
  }

  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool {
    return false
  }

  func isEqualTo(_ object: Any) -> Bool {
    guard let other = object as? Expression else { return false }
    return name == other.name
      && value == other.value
  }
}
