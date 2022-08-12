//
//  BlendShape.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import Foundation

struct BlendShape: Codable {
  let id: String = UUID().uuidString
  var a: Double
  var angry: Double
  var blink: Double
  var blinkLeft: Double
  var blinkRight: Double
  var e: Double
  var fun: Double
  var i: Double
  var joy: Double
  var lookDown: Double
  var lookLeft: Double
  var lookRight: Double
  var lookUp: Double
  var neutral: Double
  var o: Double
  var sorrow: Double
  var u: Double
  var unknown: Double
  
  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case a = "a"
    case angry = "angry"
    case blink = "blink"
    case blinkLeft = "blink_l"
    case blinkRight = "blink_r"
    case e = "e"
    case fun = "fun"
    case i = "i"
    case joy = "joy"
    case lookDown = "lookdown"
    case lookLeft = "lookleft"
    case lookRight = "lookright"
    case lookUp = "lookup"
    case neutral = "neutral"
    case o = "o"
    case sorrow = "sorrow"
    case u = "u"
    case unknown = "unknown"
  }
}

extension BlendShape: Equatable {
  static func ==(lhs: BlendShape, rhs: BlendShape) -> Bool {
    return lhs.a == rhs.a
      && lhs.angry == rhs.angry
      && lhs.blink == rhs.blink
      && lhs.blinkLeft == rhs.blinkLeft
      && lhs.blinkRight == rhs.blinkRight
      && lhs.e == rhs.e
      && lhs.fun == rhs.fun
      && lhs.i == rhs.i
      && lhs.joy == rhs.joy
      && lhs.lookDown == rhs.lookDown
      && lhs.lookLeft == rhs.lookLeft
      && lhs.lookRight == rhs.lookRight
      && lhs.lookUp == rhs.lookUp
      && lhs.neutral == rhs.neutral
      && lhs.o == rhs.o
      && lhs.sorrow == rhs.sorrow
      && lhs.u == rhs.u
      && lhs.unknown == rhs.unknown
  }
}

extension BlendShape {
  static func generateFromExpressions(_ expressions: [Expression]) -> BlendShape {
    // TODO: ❗️ UPDATE ❗️
    let transformedBlendShape = BlendShape(
      a: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.a.rawValue }) != nil) ? 1 : 0,
      angry: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.angry.rawValue }) != nil) ? 1 : 0,
      blink: expressions.first(where: { $0 is BlinkExpression })?.value ?? 0.0,
      blinkLeft: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.blinkLeft.rawValue }) != nil) ? 1 : 0,
      blinkRight: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.blinkRight.rawValue }) != nil) ? 1 : 0,
      e: 0,
      fun: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.fun.rawValue }) != nil) ? 1 : 0,
      i: 0,
      joy: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.joy.rawValue }) != nil) ? 1 : 0,
      lookDown: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.lookDown.rawValue }) != nil) ? 1 : 0,
      lookLeft: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.lookLeft.rawValue }) != nil) ? 1 : 0,
      lookRight: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.lookRight.rawValue }) != nil) ? 1 : 0,
      lookUp: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.lookUp.rawValue }) != nil) ? 1 : 0,
      neutral: (expressions.first(where: { $0.blendShapePresetName == CodingKeys.neutral.rawValue }) != nil) ? 1 : 0,
      o: 0,
      sorrow: 0,
      u: 0,
      unknown: 0
    )

    return transformedBlendShape
  }
}
