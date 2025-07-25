//
//  FortuneDetail.swift
//  Flifin
//
//  Created by hyerin on 7/4/25.
//

import SwiftUI

struct FortuneDetail: Equatable {
  var scoreInfo: FortuneScore
  let cardInfo: FortuneCard
  let detailMessage: String
  let tipInfos: [Tip]
  
  struct FortuneScore: Equatable {
    var date: String
    let scoreString: String
    let score: Int
    let summary: String
  }
  struct FortuneCard: Equatable {
    let backgroundImageURL: URL?
    let title: String
    let fortune: String
  }

  struct Tip: Equatable, Hashable {
    let imageURL: URL?
    let title: String
    let content: String
    let contentColor: Color?
  }
}

extension FortuneDetail {
  static func introInfo(date: String) -> FortuneDetail {
    .init(
      scoreInfo: .init(
        date: date,
        scoreString: "85점",
        score: 85,
        summary: "마음이 들뜨는 날이에요,\n한템포 쉬어가요."
      ),
      cardInfo: .init(
        backgroundImageURL: .urlForResource(.fortuneCardFrontDefaultView),
        title: "최고의 날",
        fortune: "네잎클로버"
      ),
      detailMessage: "오늘은 지갑을 더 단단히 쥐고 계셔야겠어요. 괜히 시선 가는 거 많고, 충동구매가 살짝 걱정되는 날이에요. 꼭 필요한 소비인지 한 번만 더 생각해보면, 내일의 나에게 분명 고마워할 거예요.\n\n행운의 색인 연두색이 들어간 소품을 곁에 두면 조금 더 차분한 하루가 될지도 몰라요.",
      tipInfos: [
        .init(
          imageURL: .urlForResource(.knife),
          title: "오늘의 추천메뉴",
          content: "카레",
          contentColor: nil
        ),
        .init(
          imageURL: .urlForResource(.clover),
          title: "행운의 색상",
          content: "연두색",
          contentColor: ColorResource._23_B_169.color
        ),
        .init(
          imageURL: .urlForResource(.greenFace),
          title: "피해야 할 음식",
          content: "치킨, 닭",
          contentColor: nil
        ),
        .init(
          imageURL: .urlForResource(.redFace),
          title: "피해야 할 색상",
          content: "흰색",
          contentColor: ColorResource.Text.main.color
        )
      ]
    )
  }
}
