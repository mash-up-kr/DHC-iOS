//
//  UserIDDTO.swift
//  Flifin
//
//  Created by hyerin on 7/1/25.
//

import Foundation

struct UserIDDTO: Decodable {
  let id: String
  
  var toDomain: String {
    id
  }
}
