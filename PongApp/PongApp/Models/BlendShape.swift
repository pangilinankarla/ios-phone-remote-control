//
//  BlendShape.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import Foundation

struct BlendShape: Codable {
  let id: String = UUID().uuidString
  var a: Decimal
  var angry: Decimal
  var blink: Decimal
  var blinkLeft: Decimal
  var blinkRight: Decimal
  var e: Decimal
  var fun: Decimal
  var i: Decimal
  var joy: Decimal
  var lookDown: Decimal
  var lookLeft: Decimal
  var lookRight: Decimal
  var lookUp: Decimal
  var neutral: Decimal
  var o: Decimal
  var sorrow: Decimal
  var u: Decimal
  var unknown: Decimal
  
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
