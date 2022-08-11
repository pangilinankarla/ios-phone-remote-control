//
//  Double+RoundingOff.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

import Foundation

extension Double {
  func roundToPlaces(_ places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
