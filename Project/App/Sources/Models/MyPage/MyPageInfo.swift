//
//  MyPageInfo.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import Foundation

struct MyPageInfo: Equatable {
  let animalCard: AnimalCardInfo
  var birthDate: BirthDateInfo
  let preferredMissionCategoryList: [MissionCategoryInfo]
}

extension MyPageInfo {
  struct AnimalCardInfo: Equatable {
    let name: String
    let cardImageURL: URL?
  }
}

extension MyPageInfo {
  struct BirthDateInfo: Equatable {
    let date: String
    let birthTime: String
  }
}

extension MyPageInfo {
  struct MissionCategoryInfo: Hashable {
    let displayName: String
    let imageURL: URL?
  }
}
