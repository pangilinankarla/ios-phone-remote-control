//
//  Decimal+RoundingOff.swift
//  PongApp
//
//  Created by Karla Pangilinan on 12/1/22.
//

import Foundation

extension Decimal {
  mutating func round(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) {
    var localCopy = self
    NSDecimalRound(&self, &localCopy, scale, roundingMode)
  }

  func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
    var result = Decimal()
    var localCopy = self
    NSDecimalRound(&result, &localCopy, scale, roundingMode)
    return result
  }
}
