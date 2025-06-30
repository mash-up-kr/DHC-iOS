//
//  MissionCategoryDTO.swift
//  Flifin
//
//  Created by hyerin on 6/30/25.
//

import Foundation

struct MissionCategoryDTO: Decodable {
  let categories: [MissionCateogry]
  
  var toDomain: [MissionCategory] {
    return categories.map { .init(name: $0.name, displayName: $0.displayName, imageURL: $0.imageURL) }
  }
}

extension MissionCategoryDTO {
  struct MissionCateogry: Decodable {
    let name: String
    let displayName: String
    let imageURL: URL?
    
    enum CodingKeys: String, CodingKey {
      case name
      case displayName
      case imageURL = "imageUrl"
    }
  }
}
