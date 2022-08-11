//
//  Move.swift
//  SocketIOApp
//
//  Created by Karla Pangilinan on 8/11/22.
//

import Foundation

struct Move: Codable, Identifiable {
  var id: String? = UUID().uuidString
  let moveUp: Bool
  let moveDown: Bool
  
  private enum CodingKeys: String, CodingKey {
    case moveUp = "move_up"
    case moveDown = "move_down"
  }
}
