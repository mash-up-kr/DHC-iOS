//
//  FortuneDetailDTO.swift
//  Flifin
//
//  Created by hyerin on 7/4/25.
//

import SwiftUI

// MARK: - FortuneDetailDTO
struct FortuneDetailDTO: Decodable {
  let date, fortuneTitle, fortuneDetail: String
  let totalScore: Int
  let tips: [TipDTO]
  let cardInfo: CardInfoDTO
  
  var toDomain: FortuneDetail {
    .init(
      scoreInfo: .init(
        date: date,
        scoreString: "\(totalScore)점",
        score: totalScore,
        summary: fortuneTitle
      ),
      cardInfo: cardInfo.toDomain,
      detailMessage: fortuneDetail,
      tipInfos: tips.map { $0.toDomain }
    )
  }
}

// MARK: - CardInfo
struct CardInfoDTO: Decodable {
  let image: String
  let title, subTitle: String
  
  var toDomain: FortuneDetail.FortuneCard {
    .init(
      backgroundImageURL: URL(string: image),
      title: title,
      fortune: subTitle
    )
  }
}

// MARK: - Tip
struct TipDTO: Decodable {
  let image: String
  let title, description: String
  let hexColor: String?
  
  var toDomain: FortuneDetail.Tip {
    .init(
      imageURL: URL(string: image),
      title: title,
      content: description,
      contentColor: Color(hexCode: hexColor)
    )
  }
}
