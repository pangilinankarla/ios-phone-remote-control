//
//  LetterExpressions.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import Accelerate
import ARKit

// MARK: - A
class LetterA: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    Decimal(faceAnchor.blendShapeDoubleValue(.jawOpen))
  }
}

class LetterI: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let lowerDownMax = 0.35
    let stretchMax = 0.25
    let eyeBlinkLeft = faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft)
    let eyeBlinkRight = faceAnchor.blendShapeDoubleValue(.eyeBlinkRight)
    let jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen)
    let mouthLowerDownLeft = faceAnchor.blendShapeDoubleValue(.mouthLowerDownLeft)
    let mouthLowerDownRight = faceAnchor.blendShapeDoubleValue(.mouthLowerDownRight)
    let mouthStretchLeft = faceAnchor.blendShapeDoubleValue(.mouthStretchLeft)
    let mouthStretchRight = faceAnchor.blendShapeDoubleValue(.mouthStretchRight)
    let mouthDimpleLeft = faceAnchor.blendShapeDoubleValue(.mouthDimpleLeft)
    let mouthDimpleRight = faceAnchor.blendShapeDoubleValue(.mouthDimpleRight)

    guard
//      neutral < 0.9,
      eyeBlinkLeft < 0.2 && eyeBlinkRight < 0.2,
      jawOpen < 0.2,
      mouthDimpleLeft < 0.1 && mouthDimpleRight < 0.1,
      mouthLowerDownLeft < 0.4 && mouthLowerDownRight < 0.4,
      (mouthLowerDownLeft - 0.08)...(mouthLowerDownLeft + 0.08) ~= mouthLowerDownRight,
      mouthStretchLeft < 0.3 && mouthStretchRight < 0.3,
      (mouthStretchLeft - 0.08)...(mouthStretchLeft + 0.08) ~= mouthStretchRight
    else { return 0.0 }

    let mouthLowerDownLeftNew = (mouthLowerDownLeft / lowerDownMax)
    let mouthLowerDownRightNew = (mouthLowerDownRight / lowerDownMax)
    let mouthLowerDownAvg = vDSP.mean([
      mouthLowerDownLeftNew,
      mouthLowerDownRightNew,
    ])

    let mouthStretchLeftNew = (mouthStretchLeft / stretchMax)
    let mouthStretchRightNew = (mouthStretchRight / stretchMax)
    let mouthStretchAvg = vDSP.mean([
      mouthStretchLeftNew,
      mouthStretchRightNew,
    ])

    let avg = vDSP.mean([
      mouthLowerDownAvg,
      mouthStretchAvg,
    ])
    return Decimal(avg)
  }
}

class LetterU: Expression {
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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let funnelMax: Double = 0.5
    let puckerMax: Double = 0.4
    //      let eyeBlinkLeft = faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft)
    //      let eyeBlinkRight = faceAnchor.blendShapeDoubleValue(.eyeBlinkRight)
    let jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen)
    let jawForward = faceAnchor.blendShapeDoubleValue(.jawForward)
    let mouthClose = faceAnchor.blendShapeDoubleValue(.mouthClose)
    let mouthFunnel = faceAnchor.blendShapeDoubleValue(.mouthFunnel)
    let mouthPucker = faceAnchor.blendShapeDoubleValue(.mouthPucker)

    guard
//      neutral < 0.9,
      //        eyeBlinkLeft < 0.2 && eyeBlinkRight < 0.2,
      jawOpen <= 0.12, jawForward <= 0.12, mouthClose <= 0.20,
      mouthFunnel <= funnelMax, mouthPucker <= puckerMax
    else { return 0.0 }

    let mouthFunnelNew = (mouthFunnel / funnelMax)
    let mouthPuckerNew = (mouthPucker / puckerMax)

    let avg = vDSP.mean([
      mouthFunnelNew,
      mouthPuckerNew
    ])
    return Decimal(avg)
  }
}

class LetterE: Expression {
  var value: Decimal = 0.0

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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let dimpleMax = 0.25
    let lowerDownMax = 0.6
    let stretchMax = 0.25
    let eyeBlinkLeft = faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft)
    let eyeBlinkRight = faceAnchor.blendShapeDoubleValue(.eyeBlinkRight)
    let jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen)
    let mouthLowerDownLeft = faceAnchor.blendShapeDoubleValue(.mouthLowerDownLeft)
    let mouthLowerDownRight = faceAnchor.blendShapeDoubleValue(.mouthLowerDownRight)
    let mouthStretchLeft = faceAnchor.blendShapeDoubleValue(.mouthStretchLeft)
    let mouthStretchRight = faceAnchor.blendShapeDoubleValue(.mouthStretchRight)
    let mouthDimpleLeft = faceAnchor.blendShapeDoubleValue(.mouthDimpleLeft)
    let mouthDimpleRight = faceAnchor.blendShapeDoubleValue(.mouthDimpleRight)

    guard
//      neutral < 0.9,
      eyeBlinkLeft < 0.2 && eyeBlinkRight < 0.2,
      jawOpen < 0.2,
      mouthDimpleLeft < 0.4 && mouthDimpleRight < 0.4,
      (mouthDimpleLeft - 0.08)...(mouthDimpleLeft + 0.08) ~= mouthDimpleRight,
      mouthLowerDownLeft < 0.7 && mouthLowerDownRight < 0.7,
      (mouthLowerDownLeft - 0.08)...(mouthLowerDownLeft + 0.08) ~= mouthLowerDownRight,
      mouthStretchLeft < 0.35 && mouthStretchRight < 0.35,
      (mouthStretchLeft - 0.08)...(mouthStretchLeft + 0.08) ~= mouthStretchRight
    else { return 0.0 }

    let mouthLowerDownLeftNew = (mouthLowerDownLeft / lowerDownMax)
    let mouthLowerDownRightNew = (mouthLowerDownRight / lowerDownMax)
    let mouthLowerDownAvg = vDSP.mean([
      mouthLowerDownLeftNew,
      mouthLowerDownRightNew,
    ])

    let mouthStretchLeftNew = (mouthStretchLeft / stretchMax)
    let mouthStretchRightNew = (mouthStretchRight / stretchMax)
    let mouthStretchAvg = vDSP.mean([
      mouthStretchLeftNew,
      mouthStretchRightNew,
    ])

    let mouthDimpleLeftNew = (mouthDimpleLeft / dimpleMax)
    let mouthDimpleRightNew = (mouthDimpleRight / dimpleMax)
    let mouthDimpleAvg = vDSP.mean([
      mouthDimpleLeftNew,
      mouthDimpleRightNew,
    ])

    let avg = vDSP.mean([
      mouthLowerDownAvg,
      mouthStretchAvg,
      mouthDimpleAvg,
    ])
    return Decimal(avg)
  }
}

class LetterO: Expression {
  var value: Decimal = 0.0

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

  func getValue(from faceAnchor: ARFaceAnchor) -> Decimal {
    let jawOpenMax = 0.48
    let funnelMax = 0.45
    let puckerMax = 0.38
    //      let eyeBlinkLeft = faceAnchor.blendShapeDoubleValue(.eyeBlinkLeft)
    //      let eyeBlinkRight = faceAnchor.blendShapeDoubleValue(.eyeBlinkRight)
    let jawForward = faceAnchor.blendShapeDoubleValue(.jawForward)
    var jawOpen = faceAnchor.blendShapeDoubleValue(.jawOpen)
    var mouthFunnel = faceAnchor.blendShapeDoubleValue(.mouthFunnel)
    var mouthPucker = faceAnchor.blendShapeDoubleValue(.mouthPucker)

    guard
//      neutral < 0.9,
      //        eyeBlinkLeft < 0.2 && eyeBlinkRight < 0.2,
      jawOpen <= 0.5,
      jawForward < 0.2,
      mouthFunnel > 0.1 && mouthFunnel <= 0.53,
      mouthPucker <= 0.45
    else { return 0.0 }

    jawOpen = jawOpen.withThreshold(jawOpenMax)
    mouthFunnel = mouthFunnel.withThreshold(funnelMax)
    mouthPucker = mouthPucker.withThreshold(puckerMax)

    let mouthFunnelNew = mouthFunnel / funnelMax
    let mouthPuckerNew = mouthPucker / puckerMax

    let avg = vDSP.mean([
      mouthFunnelNew,
      mouthPuckerNew
    ])
    print(avg)
    return Decimal(avg)
  }
}
