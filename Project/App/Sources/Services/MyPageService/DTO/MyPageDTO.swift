//
//  MyPageDTO.swift
//  Flifin
//
//  Created by Aiden.lee on 6/29/25.
//

import Foundation

struct MyPageDTO: Decodable {
  let animalCard: AnimalCardInfo
  let birthDate: BirthDateInfo
  let birthTime: String
  let preferredMissionCategoryList: [MissionCategoryInfo]
  let alarm: Bool
}

extension MyPageDTO {
  struct AnimalCardInfo: Decodable {
    let name: String
    let cardImageURL: URL?

    enum CodingKeys: String, CodingKey {
      case name
      case cardImageURL = "cardImageUrl"
    }

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      name = try container.decode(String.self, forKey: .name)

      // cardImageURL이 빈 문자열로 내려오는 경우 대응
      if let urlString = try container.decodeIfPresent(String.self, forKey: .cardImageURL),
         !urlString.isEmpty {
        cardImageURL = URL(string: urlString)
      } else {
        cardImageURL = nil
      }
    }
  }
}

extension MyPageDTO {
  struct BirthDateInfo: Decodable {
    let date: String
    let calendarType: CalendarType

    enum CalendarType: String, Decodable, CaseIterable {
      case solar = "SOLAR"
      case lunar = "LUNAR"
    }
  }
}

extension MyPageDTO {
  struct MissionCategoryInfo: Decodable {
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

extension MyPageDTO {
  func toDomain() -> MyPageInfo {
    MyPageInfo(
      animalCard: .init(
        name: animalCard.name,
        cardImageURL: animalCard.cardImageURL
      ),
      birthDate: .init(
        date: birthDate.date,
        birthTime: birthTime
      ),
      preferredMissionCategoryList: preferredMissionCategoryList.map {
        .init(displayName: $0.displayName, imageURL: $0.imageURL)
      }
    )
  }
}
