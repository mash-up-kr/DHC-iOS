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

extension MyPageInfo {
  static let sample = MyPageInfo(
    animalCard: .init(
      name: "가을의 흰말",
      cardImageURL: nil
    ),
    birthDate: .init(date: "2000-01-01", birthTime: "09:30:00"),
    preferredMissionCategoryList: [
      .init(displayName: "식음료", imageURL: nil),
      .init(displayName: "디지털·구독", imageURL: nil),
      .init(displayName: "사교·모임", imageURL: nil),
    ]
  )
}
