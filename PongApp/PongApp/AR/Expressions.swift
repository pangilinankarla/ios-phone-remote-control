//
//  Expressions.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import Accelerate
import ARKit

// MARK: - Neutral
class Neutral: Expression {
  var name: String {
    "Neutral"
  }

  var blendShapePresetName: String {
    "neutral"
  }

  var description: String {
    name.lowercased()
  }

//  func isExpressing(from: ARFaceAnchor) -> Bool {
//    guard
//      let mouthClose = from.blendShapes[.mouthClose],
//      let jawOpen = from.blendShapes[.jawOpen]
//    else { return false }
//
//    return mouthClose.doubleValue.roundToPlaces(2) < 0.1
//     && jawOpen.doubleValue.roundToPlaces(2) < 0.3
//  }
//
//  func isDoingWrongExpression(from: ARFaceAnchor) -> Bool {
//    guard
//      let eyeSquintLeft = from.blendShapes[.eyeSquintLeft],
//      let eyeSquintRight = from.blendShapes[.eyeSquintRight],
//      let eyeWideLeft = from.blendShapes[.eyeWideLeft],
//      let eyeWideRight = from.blendShapes[.eyeWideRight]
//    else { return false }
//
//    return eyeSquintLeft.doubleValue.roundToPlaces(1) > 0.7
//      && eyeSquintRight.doubleValue.roundToPlaces(1) > 0.7
//      && eyeWideLeft.doubleValue.roundToPlaces(1) > 0.7
//      && eyeWideRight.doubleValue.roundToPlaces(1) > 0.7
//  }

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let eyeBlinkLeft = faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft)
    let eyeBlinkRight = faceAnchor.blendShapeDoubleValue(.eyeBlinkRight)
    let jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen)
    let mouthSmileLeft = faceAnchor.blendShapeDoubleValue(.mouthSmileLeft)
    let mouthSmileRight = faceAnchor.blendShapeDoubleValue(.mouthSmileRight)

    guard
      (eyeBlinkLeft - 0.08)...(eyeBlinkLeft + 0.08) ~= eyeBlinkRight,
      (mouthSmileLeft - 0.08)...(mouthSmileLeft + 0.08) ~= mouthSmileLeft
    else { return 0.0 }

    let noBLinkLeft = 1.0 - eyeBlinkLeft
    let noBLinkRight = 1.0 - eyeBlinkRight
    let noBLinkAvg = vDSP.mean([
      noBLinkLeft,
      noBLinkRight,
    ])

    let noSmileLeft = 1.0 - mouthSmileLeft
    let noSmileRight = 1.0 - mouthSmileRight
    let noSmileAvg = vDSP.mean([
      noSmileLeft,
      noSmileRight,
    ])

    let noJawOpen = 1.0 - jawOpen

    let avg = vDSP.mean([
      noJawOpen,
      noBLinkAvg,
      noSmileAvg
    ]).roundToPlaces(4)

    return Decimal(avg)
  }
}

// MARK: - LookLeft
class LookLeft: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let arr: [Double] = [
      faceAnchor.blendShapeDoubleValue(.eyeLookInLeft),
      faceAnchor.blendShapeDoubleValue(.eyeLookOutRight),
    ]
    let avg = vDSP.mean(arr).roundToPlaces(4)
    return Decimal(avg)
  }
}

// MARK: - LookRight
class LookRight: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let arr: [Double] = [
      faceAnchor.blendShapeDoubleValue(.eyeLookInRight),
      faceAnchor.blendShapeDoubleValue(.eyeLookOutLeft),
    ]
    let avg = vDSP.mean(arr).roundToPlaces(4)
    return Decimal(avg)
  }
}

// MARK: - LookUp
class LookUp: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let arr: [Double] = [
      faceAnchor.blendShapeDoubleValue(.eyeLookUpLeft),
      faceAnchor.blendShapeDoubleValue(.eyeLookUpRight),
    ]
    let avg = vDSP.mean(arr).roundToPlaces(4)
    return Decimal(avg)
  }
}

// MARK: - LookDown
class LookDown: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let arr: [Double] = [
      faceAnchor.blendShapeDoubleValue(.eyeLookDownLeft),
      faceAnchor.blendShapeDoubleValue(.eyeLookDownRight),
    ]
    let avg = vDSP.mean(arr).roundToPlaces(4)
    return Decimal(avg)
  }
}

// MARK: - Blink
class Blink: Expression {
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
    let targetValue = 0.4
    let eyeBlinkLeft = from.blendShapes[.eyeBlinkLeft]
    let eyeBlinkRight = from.blendShapes[.eyeBlinkRight]
    let eyeBlinkLeftRounded = eyeBlinkLeft?.doubleValue.roundToPlaces(3)
    let eyeBlinkRightRounded = eyeBlinkRight?.doubleValue.roundToPlaces(3)
    
    guard
      let eyeBlinkLeftRounded = eyeBlinkLeftRounded,
      let eyeBlinkRightRounded = eyeBlinkRightRounded,
      eyeBlinkLeftRounded > targetValue,
      eyeBlinkRightRounded > targetValue
    else { return false }

    return true
  }

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    0.0
  }
}

// MARK: - BlinkLeft
class BlinkLeft: Expression {
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
  
  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    return Decimal(faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft))
  }
}

// MARK: - BlinkRight
class BlinkRight: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    return Decimal(faceAnchor.blendShapeDoubleValue(.eyeBlinkRight))
  }
}

class Angry: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let browDownMin = 0.02
    let browDownMax = 0.15
    let frownMin = 0.15
    let frownMax = 0.5
    let squintMax = 0.2
    let eyeSquintLeft = faceAnchor.blendShapeDoubleValue(.eyeSquintLeft, max: squintMax)
    let eyeSquintRight = faceAnchor.blendShapeDoubleValue(.eyeSquintRight, max: squintMax)
    let browDownL = faceAnchor.blendShapeDoubleValue(.browDownLeft)
    let browDownR = faceAnchor.blendShapeDoubleValue(.browDownRight)
    let browInner = faceAnchor.blendShapeDoubleValue(.browInnerUp)
    let jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen)
    let mouthClose = faceAnchor.blendShapeDoubleValue(.mouthClose)
    let mouthFrownLeft = faceAnchor.blendShapeDoubleValue(.mouthFrownLeft, max: frownMax)
    let mouthFrownRight = faceAnchor.blendShapeDoubleValue(.mouthFrownRight, max: frownMax)

    guard
      browInner < 0.1,
      mouthClose < 0.1,
      jawOpen < 0.1,
      browDownL > 0.02 && browDownR > 0.02,
      mouthFrownLeft > frownMin && mouthFrownRight > frownMin,
      eyeSquintLeft < 0.6 && eyeSquintRight < 0.6
    else { return 0.0 }

    let browDownLeftNew = (browDownL - browDownMin) / (browDownMax - browDownMin)
    let browDownRightNew = (browDownR - browDownMin) / (browDownMax - browDownMin)
    let browDownAvg = vDSP.mean([
      browDownLeftNew,
      browDownRightNew,
    ])

    let mouthFrownLeftNew = (mouthFrownLeft - frownMin) / (frownMax - frownMin)
    let mouthFrownRightNew = (mouthFrownRight - frownMin) / (frownMax - frownMin)
    let mouthFrownAvg = vDSP.mean([
      mouthFrownLeftNew,
      mouthFrownRightNew,
    ])

    let squintLeftNew = (eyeSquintLeft / squintMax)
    let squintRightNew = (eyeSquintRight / squintMax)
    let squintAvg = vDSP.mean([
      squintLeftNew,
      squintRightNew,
    ])

    let avg = vDSP.mean([
      mouthFrownAvg,
      browDownAvg * 0.2,
      squintAvg,
    ])
    return Decimal(avg)
  }
}
  
class Joy: Expression {
  var value: Decimal = 0.0

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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let smileMax = 0.7
    let jawMax = 0.8
    let blinkMax = 0.9
    let eyeBlinkLeft = faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft, max: blinkMax)
    let eyeBlinkRight = faceAnchor.blendShapeDoubleValue(.eyeBlinkRight, max: blinkMax)
    let jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen, max: jawMax)
    let mouthSmileLeft = faceAnchor.blendShapeDoubleValue(.mouthSmileLeft, max: smileMax)
    let mouthSmileRight = faceAnchor.blendShapeDoubleValue(.mouthSmileRight, max: smileMax)
    let mouthDimpleLeft = faceAnchor.blendShapeDoubleValue(.mouthDimpleLeft)
    let mouthDimpleRight = faceAnchor.blendShapeDoubleValue(.mouthDimpleRight)

    guard
      mouthSmileLeft >= 0.1,
      mouthSmileRight >= 0.1,
      mouthDimpleLeft <= 0.4 && mouthDimpleRight <= 0.4,
      (eyeBlinkLeft - 0.06)...(eyeBlinkLeft + 0.06) ~= eyeBlinkRight,
      (mouthSmileLeft - 0.06)...(mouthSmileLeft + 0.06) ~= mouthSmileRight,
      abs(eyeBlinkLeft - mouthSmileLeft) <= 0.25,
      abs(eyeBlinkRight - mouthSmileRight) <= 0.25
    else { return 0.0 }

    let blinkLeftNew = (eyeBlinkLeft / blinkMax)
    let blinkRightNew = (eyeBlinkRight / blinkMax)

    let smileLeftNew = (mouthSmileLeft / smileMax)
    let smileRightNew = (mouthSmileRight / smileMax)

    let jawOpenNew = jawOpen / jawMax

    let avg = vDSP.mean([
      blinkLeftNew,
      blinkRightNew,
      smileLeftNew,
      smileRightNew,
      jawOpenNew
    ])
    return Decimal(avg)
  }
}

class Fun: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let smileMax = 0.4
    let dimpleMax = 0.55
    let squintMax = 0.55
    let eyeBlinkLeft = faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft)
    let eyeBlinkRight = faceAnchor.blendShapeDoubleValue(.eyeBlinkRight)
    let eyeSquintL = faceAnchor.blendShapeDoubleValue(.eyeSquintLeft, max: squintMax)
    let eyeSquintR = faceAnchor.blendShapeDoubleValue(.eyeSquintRight, max: squintMax)
    let jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen)
    let mouthClose = faceAnchor.blendShapeDoubleValue(.mouthClose)
    let mouthSmileLeft = faceAnchor.blendShapeDoubleValue(.mouthSmileLeft, max: smileMax)
    let mouthSmileRight = faceAnchor.blendShapeDoubleValue(.mouthSmileRight, max: smileMax)
    let mouthDimpleLeft = faceAnchor.blendShapeDoubleValue(.mouthDimpleLeft)
    let mouthDimpleRight = faceAnchor.blendShapeDoubleValue(.mouthDimpleRight)

    guard
//      neutral < 0.9,
      eyeBlinkLeft <= 0.3 && eyeBlinkRight <= 0.3,
      jawOpen < 0.15, mouthClose < 0.15
    else { return 0.0 }


    let smileLeftNew = (mouthSmileLeft / smileMax)
    let smileRightNew = (mouthSmileRight / smileMax)
    let smileAvg = vDSP.mean([
      smileLeftNew,
      smileRightNew,
    ])

    let dimpleLeftNew = (mouthDimpleLeft / dimpleMax)
    let dimpleRightNew = (mouthDimpleRight / dimpleMax)
    let dimpleAvg = vDSP.mean([
      dimpleLeftNew,
      dimpleRightNew,
    ])


    let squintLeftNew = (eyeSquintL / squintMax)
    let squintRightNew = (eyeSquintR / squintMax)
    let squintAvg = vDSP.mean([
      squintLeftNew,
      squintRightNew,
    ])

    let avg = vDSP.mean([
      smileAvg,
      dimpleAvg,
      squintAvg,
    ])

    return Decimal(avg)
  }
}

class Sorrow: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let mouthFrownMax = 0.7
    let browInnerUp = faceAnchor.blendShapeDoubleValue(.browInnerUp)
    let mouthFrownLeft = faceAnchor.blendShapeDoubleValue(.mouthFrownLeft)
    let mouthFrownRight = faceAnchor.blendShapeDoubleValue(.mouthFrownRight)

    guard
      browInnerUp <= 0.25,
      (mouthFrownLeft - 0.06)...(mouthFrownLeft + 0.06) ~= mouthFrownRight
    else { return 0.0 }

    let mouthFrownLeftNew = (mouthFrownLeft / mouthFrownMax)
    let mouthFrownRightNew = (mouthFrownRight / mouthFrownMax)

    print("mouthFrown new \(mouthFrownLeftNew), \(mouthFrownRightNew)")

    let avg = vDSP.mean([
      mouthFrownLeftNew,
      mouthFrownRightNew
    ]).roundToPlaces(4)
    print("avg \(avg)")

    return Decimal(avg)
  }
}
