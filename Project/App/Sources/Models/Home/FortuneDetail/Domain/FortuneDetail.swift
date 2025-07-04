//
//  FortuneDetail.swift
//  Flifin
//
//  Created by hyerin on 7/4/25.
//

import SwiftUI

struct FortuneDetail {
  let scoreInfo: FortuneScore
  let cardInfo: FortuneCard
  let detailMessage: String
  let tipInfos: [Tip]
  
  struct FortuneScore {
    let date: String
    let score: Int
    let summary: String
  }
  struct FortuneCard {
    let backgroundImageURL: URL?
    let title: String
    let fortune: String
  }

  struct Tip {
    let imageURL: URL?
    let title: String
    let content: String
    let contentColorHex: Color?
  }
}
