//
//  Data+Decoder.swift
//  SocketIOApp
//
//  Created by Karla Pangilinan on 8/11/22.
//

import Foundation

extension Data {
  func decodeToObject<T: Codable>() -> T? {
    do {
      return try JSONDecoder().decode(T.self, from: self)
    } catch let DecodingError.dataCorrupted(context) {
      print(context)
    } catch let DecodingError.keyNotFound(key, context) {
      print("Key '\(key)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.valueNotFound(value, context) {
      print("Value '\(value)' not found:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch let DecodingError.typeMismatch(type, context)  {
      print("Type '\(type)' mismatch:", context.debugDescription)
      print("codingPath:", context.codingPath)
    } catch {
      print("error: ", error)
    }
    
    return nil
  }
}
