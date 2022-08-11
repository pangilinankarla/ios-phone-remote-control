//
//  FacialExpression.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

struct FacialExpression: Codable, Equatable {
  var mouthSmileLeft: Double = 0.0
  var mouthSmileRight: Double = 0.0
  var cheekPuff: Double = 0.0
  var tongueOut: Double = 0.0
  var jawOpen: Double = 0.0
  var eyeSquintLeft: Double = 0.0
  var eyeSquintRight: Double = 0.0
  var eyeWideLeft: Double = 0.0
  var eyeWideRight: Double = 0.0
  var eyeBlinkLeft: Double = 0.0
  var eyeBlinkRight: Double = 0.0
  
  private enum CodingKeys: String, CodingKey {
    case mouthSmileLeft = "mouth_smile_left"
    case mouthSmileRight = "mouth_smile_right"
    case cheekPuff = "cheek_puff"
    case tongueOut = "tongue_out"
    case jawOpen = "jaw_open"
    case eyeSquintLeft = "eye_squint_left"
    case eyeSquintRight = "eye_squint_right"
    case eyeWideLeft = "eye_wide_left"
    case eyeWideRight = "eye_wide_right"
    case eyeBlinkLeft = "eye_blink_left"
    case eyeBlinkRight = "eye_blink_right"
  }
}
