//
//  FortuneDetailInfo.swift
//  Flifin
//
//  Created by 최혜린 on 6/22/25.
//

import SwiftUI

struct FortuneDetailInfo: Equatable {
  let scoreInfo: FortuneScoreInfo
  let cardInfo: FortuneCardInfo
  let detailMessage: String
  let tipInfos: [TipInfo]
}

struct FortuneScoreInfo: Equatable {
  let date: String
  let score: Int
  let summary: String
}
struct FortuneCardInfo: Equatable {
  let backgroundImageURL: URL
  let title: String
  let fortune: String
}

struct TipInfo: Equatable, Hashable {
  let imageURL: URL
  let title: String
  let content: String
  let contentColor: Color?
}
