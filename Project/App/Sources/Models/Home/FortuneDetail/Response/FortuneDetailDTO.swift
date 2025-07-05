//
//  FortuneDetailDTO.swift
//  Flifin
//
//  Created by hyerin on 7/4/25.
//

import SwiftUI

struct FortuneDetailDTO: Codable {
  let date, fortuneTitle, fortuneDetail, jinxedColor: String
  let jinxedColorHex: String
  let jinxedColorImageURL: String
  let jinxedMenu: String
  let jinxedMenuImageURL: String
  let jinxedNumber: Int
  let luckyColor, luckyColorHex: String
  let luckyColorImageURL: String
  let luckyNumber, positiveScore, negativeScore, totalScore: Int
  let todayMenu: String
  let todayMenuImageURL: String
  let luckyColorType, jinxedColorType: String
  
  enum CodingKeys: String, CodingKey {
    case date, fortuneTitle, fortuneDetail, jinxedColor, jinxedColorHex
    case jinxedColorImageURL = "jinxedColorImage"
    case jinxedMenu
    case jinxedMenuImageURL = "jinxedMenuImage"
    case jinxedNumber, luckyColor, luckyColorHex
    case luckyColorImageURL = "luckyColorImage"
    case luckyNumber, positiveScore, negativeScore, totalScore, todayMenu
    case todayMenuImageURL = "todayMenuImage"
    case luckyColorType, jinxedColorType
  }
}

extension FortuneDetailDTO {
  var toDomain: FortuneDetail {
    .init(
      scoreInfo: .init(
        date: date,
        scoreString: "\(totalScore)점",
        score: totalScore,
        summary: fortuneTitle
      ),
      cardInfo: .init(
        backgroundImageURL: .urlForResource(.fortuneCardFrontDefaultView),
        title: "최고의 날",
        fortune: "네잎클로버"
      ),
      detailMessage: fortuneDetail,
      tipInfos: [
        .init(
          imageURL: URL(string: todayMenuImageURL),
          title: "오늘의 추천메뉴",
          content: todayMenu,
          contentColor: nil
        ),
        .init(
          imageURL: URL(string: luckyColorImageURL),
          title: "행운의 색상",
          content: luckyColor,
          contentColor: Color(hexCode: luckyColorHex)
        ),
        .init(
          imageURL: URL(string: jinxedMenuImageURL),
          title: "피해야 할 음식",
          content: jinxedMenu,
          contentColor: nil
        ),
        .init(
          imageURL: URL(string: jinxedColorImageURL),
          title: "피해야 할 색상",
          content: jinxedColor,
          contentColor: Color(hexCode: jinxedColorHex)
        )
      ]
    )
  }
}
