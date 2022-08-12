//
//  Expression.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import ARKit

protocol Expression {
  func name() -> String

  func blendShapePresetName() -> String
  
  // should return true when the ARFaceAnchor is performing the expression we want
  func isExpressing(from: ARFaceAnchor) -> Bool
}

extension Expression {
  func isExpressing(from: ARFaceAnchor) -> Bool {
    return false
  }
}
