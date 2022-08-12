//
//  IsEqual.swift
//  PongApp
//
//  Created by Karla Pangilinan on 8/12/22.
//

protocol IsEqual {
  func isEqualTo(_ object: Any) -> Bool
}

func == (lhs: IsEqual?, rhs: IsEqual?) -> Bool {
  guard let lhs = lhs else { return rhs == nil }
  guard let rhs = rhs else { return false }
  return lhs.isEqualTo(rhs) }

func == (lhs: [IsEqual]?, rhs: [IsEqual]?) -> Bool {
  guard let lhs = lhs else { return rhs == nil }
  guard let rhs = rhs else { return false }
  
  guard lhs.count == rhs.count else { return false }
  for i in 0..<lhs.count {
    if !lhs[i].isEqualTo(rhs[i]) {
      return false
    }
  }
  return true
}
