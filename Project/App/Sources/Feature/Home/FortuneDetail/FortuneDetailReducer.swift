//
//  FortuneDetailReducer.swift
//  ProductName
//
//  Created by 최혜린 on 6/22/25.
//

import ComposableArchitecture

import SwiftUI

enum FortuneDetailType {
  case intro
  case detail
}

@Reducer
struct FortuneDetailReducer {
  init() {}

  @ObservableState
  struct State: Equatable {
    let type: FortuneDetailType
    var detailInfo = FortuneDetailInfo(
      scoreInfo: .init(
        date: "2025년 5월 20일",
        score: 35,
        summary: "마음이 들뜨는 날이에요,\n한템포 쉬어가요."
      ),
      cardInfo: .init(
        backgroundImageURL: URL(string: "https://img.freepik.com/free-vector/dark-gradient-background-with-copy-space_53876-99548.jpg")!,
        title: "최고의 날",
        fortune: "네잎클로버"
      ),
      detailMessage: "오늘은 지갑을 더 단단히 쥐고 계셔야겠어요. 괜히 시선 가는 거 많고, 충동구매가 살짝 걱정되는 날이에요. 꼭 필요한 소비인지 한 번만 더 생각해보면, 내일의 나에게 분명 고마워할 거예요.\n\n행운의 색인 연두색이 들어간 소품을 곁에 두면 조금 더 차분한 하루가 될지도 몰라요.",
      tipInfos: [
        .init(
          imageURL: URL(string: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png")!,
          title: "오늘의 추천메뉴",
          content: "카레",
          contentColor: nil
        ),
        .init(
          imageURL: URL(string: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png")!,
          title: "행운의 색상",
          content: "연두색",
          contentColor: ColorResource.Violet._300.color
        ),
        .init(
          imageURL: URL(string: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png")!,
          title: "오늘의 추천메뉴2",
          content: "카레",
          contentColor: nil
        ),
        .init(
          imageURL: URL(string: "https://cdn.freebiesupply.com/images/large/2x/apple-logo-transparent.png")!,
          title: "행운의 색상2",
          content: "연두색",
          contentColor: ColorResource.Violet._300.color
        )
      ]
    )

    init(type: FortuneDetailType) {
      self.type = type
    }
  }

  enum Action {
    // View Action
    case nextButtonTapped
    case backButtonTapped
    
    // Internal Action
    
    // Route Action
  }

  var body: some Reducer<State, Action> {
    Reduce { state, action in
      switch action {
      case .nextButtonTapped:
        return .none
        
      case .backButtonTapped:
        return .none
      }
    }
  }
}
